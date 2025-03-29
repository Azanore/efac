import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/widgets/custom_scrollbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/widgets/admin_user_list_item_widget_v2.dart';
import 'package:e_facture/core/services/admin_user_service.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/pages/admin/admin_invoices_page.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  bool _expandAll = false;
  final ScrollController _scrollController = ScrollController();
  int _offset = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  bool? _isActiveFilter;
  bool _showFilterOptions = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchMode = false;
  DateTime? _lastLoadTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetAndLoadUsers();
    });

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_hasReachedEnd) {
      _loadUsers();
    }
  }

  Future<void> _resetAndLoadUsers() async {
    final userService = Provider.of<AdminUserService>(context, listen: false);
    userService.resetState();
    setState(() {
      _offset = 0;
      _hasReachedEnd = false;
      _searchQuery = '';
      _searchController.clear();
      _isSearchMode = false;
      _isActiveFilter = null;
    });
    await _loadUsers();
  }

  Future<void> _loadUsers() async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }
    _lastLoadTime = now;

    if (_isLoadingMore) return;

    final userService = Provider.of<AdminUserService>(context, listen: false);

    setState(() {
      _isLoadingMore = true;
    });

    if (_isSearchMode && _searchQuery.isNotEmpty) {
      await userService.searchUsers(
        context,
        keyword: _searchQuery,
        limit: _limit,
        offset: _offset,
        isActive: _isActiveFilter,
      );
    } else {
      await userService.fetchUsers(
        context,
        limit: _limit,
        offset: _offset,
        isActive: _isActiveFilter,
      );
    }

    setState(() {
      _offset = userService.users.length;
      if (userService.users.length >= userService.totalUsers) {
        _hasReachedEnd = true;
      }
      _isLoadingMore = false;
    });
  }

  void _applyActiveFilter(bool? value) {
    final userService = Provider.of<AdminUserService>(context, listen: false);
    userService.resetState();
    setState(() {
      _isActiveFilter = value;
      _offset = 0;
      _hasReachedEnd = false;
      _showFilterOptions = false;
    });
    _loadUsers();
  }

  void _resetFilters() {
    final userService = Provider.of<AdminUserService>(context, listen: false);
    userService.resetState();
    setState(() {
      _isActiveFilter = null;
      _offset = 0;
      _hasReachedEnd = false;
      _showFilterOptions = false;
      _searchQuery = '';
      _searchController.clear();
      _isSearchMode = false;
    });
    _loadUsers();
  }

  void _searchUsers() {
    if (_searchController.text.trim().isEmpty) {
      return;
    }

    final userService = Provider.of<AdminUserService>(context, listen: false);
    userService.resetState();
    setState(() {
      _searchQuery = _searchController.text.trim();
      _offset = 0;
      _hasReachedEnd = false;
      _isSearchMode = true;
      _showFilterOptions = false;
    });
    _loadUsers();
  }

  void _toggleExpandAll() {
    setState(() {
      _expandAll = !_expandAll;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildFooterWidget() {
    if (_isLoadingMore) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_hasReachedEnd) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            S.of(context).allUsersLoaded,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.borderColor(context),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<AdminUserService>(context);
    final isDarkMode = AppColors.isDark(context);

    return Scaffold(
      appBar: AppBarWidget(
        rightAction: QuickSettingsWidget(),
        title: S.of(context).adminUsersManagement,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardColor(context),
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundColor(
                    context,
                  ).withAlpha((255 * 0.05).toInt()),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.filter_list,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                      label: Icon(
                        _showFilterOptions
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _showFilterOptions = !_showFilterOptions;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isActiveFilter != null
                                ? AppColors.primaryColor(context)
                                : AppColors.buttonColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              isDarkMode
                                  ? AppColors.backgroundColor(
                                    context,
                                  ).withAlpha((255 * 0.5).toInt())
                                  : Colors.white,
                          border: Border.all(
                            color: AppColors.borderColor(context),
                            width: 0.5,
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: S.of(context).searchUserPlaceholder,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.iconColor(
                                context,
                              ).withAlpha(180),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryColor(context),
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            suffixIcon:
                                _searchController.text.isNotEmpty
                                    ? IconButton(
                                      icon: Icon(Icons.clear, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        if (_isSearchMode) {
                                          _resetFilters();
                                        }
                                      },
                                    )
                                    : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor(context),
                            height: 1.2,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          onSubmitted: (_) => _searchUsers(),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    if (_isActiveFilter != null || _isSearchMode)
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.iconColor(context),
                        ),
                        onPressed: _resetFilters,
                        tooltip: S.of(context).clearFilter,
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),

                    IconButton(
                      icon: Icon(
                        _expandAll ? Icons.unfold_less : Icons.unfold_more,
                        color: AppColors.iconColor(context),
                      ),
                      onPressed: _toggleExpandAll,
                      tooltip:
                          _expandAll
                              ? S.of(context).collapseAll
                              : S.of(context).expandAll,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ],
                ),

                if (_showFilterOptions)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? AppColors.backgroundColor(
                                context,
                              ).withAlpha((255 * 0.3).toInt())
                              : AppColors.backgroundColor(
                                context,
                              ).withAlpha((255 * 0.5).toInt()),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor(
                          context,
                        ).withAlpha((255 * 0.5).toInt()),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).filterByStatus,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textColor(context),
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildFilterOption(
                          S.of(context).allUsers,
                          null,
                          _isActiveFilter == null,
                        ),
                        _buildFilterOption(
                          S.of(context).activeUsers,
                          true,
                          _isActiveFilter == true,
                        ),
                        _buildFilterOption(
                          S.of(context).inactiveUsers,
                          false,
                          _isActiveFilter == false,
                        ),
                      ],
                    ),
                  ),

                if ((_isActiveFilter != null || _isSearchMode) &&
                    !_showFilterOptions)
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? AppColors.backgroundColor(
                                context,
                              ).withAlpha((255 * 0.3).toInt())
                              : AppColors.backgroundColor(context),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor(context),
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isActiveFilter != null)
                          Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                size: 14,
                                color: AppColors.iconColor(
                                  context,
                                ).withAlpha(180),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '${S.of(context).status}: ${_isActiveFilter! ? S.of(context).activeUsersStatus : S.of(context).inactiveUsersStatus}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textColor(context),
                                ),
                              ),
                            ],
                          ),
                        if (_isSearchMode)
                          Padding(
                            padding: EdgeInsets.only(
                              top: _isActiveFilter != null ? 4 : 0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 14,
                                  color: AppColors.iconColor(
                                    context,
                                  ).withAlpha(180),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${S.of(context).search}: "$_searchQuery"',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textColor(context),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).userCount(userService.totalUsers),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor(context).withOpacity(0.7),
                ),
              ),
            ),
          ),

          Expanded(
            child:
                userService.isLoading && _offset == 0
                    ? Center(child: CircularProgressIndicator())
                    : userService.error != null
                    ? Center(
                      child: Text(
                        '${S.of(context).error}: ${userService.error}',
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: _resetAndLoadUsers,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            userService.users.isEmpty
                                ? Center(
                                  child: Text(
                                    S.of(context).noUserFound,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textColor(context),
                                    ),
                                  ),
                                )
                                : CustomScrollbar(
                                  controller: _scrollController,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: userService.users.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index < userService.users.length) {
                                        final user = userService.users[index];
                                        return AdminUserListItemWidgetV2(
                                          user: user,
                                          expandAll: _expandAll,
                                          onToggleStatus: () {
                                            userService.toggleUserStatus(
                                              context,
                                              user.id,
                                              !user.isActive,
                                            );
                                          },
                                          onViewInvoices: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => AdminInvoicesPage(
                                                      userId: user.id,
                                                    ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return _buildFooterWidget();
                                      }
                                    },
                                  ),
                                ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String title, bool? value, bool isSelected) {
    final isDarkMode = AppColors.isDark(context);
    return InkWell(
      onTap: () => _applyActiveFilter(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryColor(context).withAlpha(
                    isDarkMode ? (255 * 0.2).toInt() : (255 * 0.1).toInt(),
                  )
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 20,
              color:
                  isSelected
                      ? AppColors.primaryColor(context)
                      : AppColors.iconColor(context),
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color:
                    isSelected
                        ? AppColors.primaryColor(context)
                        : AppColors.textColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
