import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_list/user_list_bloc.dart';
import '../bloc/user_list/user_list_event.dart';
import '../bloc/user_list/user_list_state.dart';

/// User list screen - Displays users from API with offline caching
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch users when page loads
    context.read<UserListBloc>().add(const FetchUsersEvent());
  }

  void _refreshUsers() {
    context.read<UserListBloc>().add(const RefreshUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUsers,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _refreshUsers();
                await Future.delayed(const Duration(seconds: 1));
              },
              child: Column(
                children: [
                  // Offline indicator
                  if (state.isFromCache)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: AppTheme.buzzYellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_off,
                            size: 16,
                            color: AppTheme.buzzBlack,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Offline Mode - Showing cached data',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  // User list
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return _UserListItem(user: user);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserListError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading users',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _refreshUsers,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _UserListItem extends StatelessWidget {
  final User user;

  const _UserListItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.avatar),
          backgroundColor: AppTheme.buzzYellow,
        ),
        title: Text(
          user.fullName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          user.email,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.buzzBlack),
        onTap: () {
          // Show user details
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(user.fullName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  const SizedBox(height: 16),
                  Text('Email: ${user.email}'),
                  Text('ID: ${user.id}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
