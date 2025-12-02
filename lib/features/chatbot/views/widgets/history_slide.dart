import 'package:edutech_app/core/theme/app_colors.dart';
import 'package:edutech_app/core/theme/app_typography.dart';
import 'package:edutech_app/features/chatbot/controllers/chat_controller.dart';
import 'package:edutech_app/features/chatbot/models/sessions_with_title.dart';
import 'package:edutech_app/features/chatbot/views/widgets/chat_message_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const HistoryDrawer({super.key, required this.isOpen, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.75;

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          right: isOpen ? 0 : -drawerWidth,
          top: 0,
          bottom: 0,
          width: drawerWidth,
          child: Material(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(color: AppColors.sky50),
              child: SafeArea(
                child: Column(
                  children: const [
                    _SearchBar(),
                    _NewChatButton(),
                    SizedBox(height: 8),
                    Expanded(child: _SessionsList()),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Snackbar container positioned on top of the drawer
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: const _SnackbarContainer(),
        ),
      ],
    );
  }
}

/// Container for showing snackbars on top of drawer
class _SnackbarContainer extends StatelessWidget {
  const _SnackbarContainer();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// Search bar widget with search functionality
class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Listen to search query changes from controller to sync UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ChatController>();
      if (controller.searchQuery.isEmpty && _searchController.text.isNotEmpty) {
        _searchController.clear();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to controller to clear text field when search is cleared externally
    final searchQuery = context.select<ChatController, String>(
      (controller) => controller.searchQuery,
    );

    if (searchQuery.isEmpty && _searchController.text.isNotEmpty) {
      _searchController.clear();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          boxShadow: [AppColors.shadowMedium],
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          style: const TextStyle(color: AppColors.neutral900, fontSize: 14),
          onChanged: (value) {
            context.read<ChatController>().updateSearchQuery(value);
          },
          decoration: InputDecoration(
            hintText: 'Search for chats',
            hintStyle: TextStyle(color: AppColors.neutral500, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),

            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.neutral500,
                      size: 20,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _focusNode.unfocus();
                      context.read<ChatController>().updateSearchQuery('');
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

/// New chat button
class _NewChatButton extends StatelessWidget {
  const _NewChatButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          final controller = context.read<ChatController>();
          controller.createNewSession();
          controller.closeHistory();
        },
        child: Row(
          children: [
            Icon(Icons.add, color: AppColors.buttonprimary, size: 18),
            const SizedBox(width: 8),
            Text(
              'New chat',
              style: AppTypography.small.copyWith(
                color: AppColors.buttonprimary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 16),
            Image.asset(
              'assets/icons/messege.svg',
              width: 16,
              height: 16,
              color: AppColors.buttonprimary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Sessions list with pagination and search
class _SessionsList extends StatefulWidget {
  const _SessionsList();

  @override
  State<_SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<_SessionsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ChatController>();
      if (controller.sessions.isEmpty && !controller.isLoadingSessions) {
        controller.fetchSessions(refresh: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final controller = context.read<ChatController>();
      if (!controller.isLoadingSessions && controller.hasMoreSessions) {
        controller.fetchSessions();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessions = context.select<ChatController, List<SessionWithTitle>>(
      (controller) => controller.filteredSessions,
    );

    final isLoadingSessions = context.select<ChatController, bool>(
      (controller) => controller.isLoadingSessions,
    );

    final currentSessionId = context.select<ChatController, String?>(
      (controller) => controller.sessionId,
    );

    final searchQuery = context.select<ChatController, String>(
      (controller) => controller.searchQuery,
    );

    if (sessions.isEmpty && isLoadingSessions) {
      return const HistorySessionsShimmer();
    }

    if (sessions.isEmpty && !isLoadingSessions) {
      return _EmptyState(isSearching: searchQuery.isNotEmpty);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: sessions.length + (isLoadingSessions ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == sessions.length) {
          return const _LoadingIndicator();
        }

        final session = sessions[index];
        final isActive = session.sessionId == currentSessionId;
        final title = session.title ?? 'New Chat';
        final displayTitle = title.length <= 45
            ? title
            : '${title.substring(0, 45)}...';

        return _SessionItem(
          sessionId: session.sessionId,
          isActive: isActive,
          title: displayTitle,
        );
      },
    );
  }
}

/// Session item with long press to delete
class _SessionItem extends StatelessWidget {
  final String sessionId;
  final bool isActive;
  final String title;

  const _SessionItem({
    required this.sessionId,
    required this.isActive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final controller = context.read<ChatController>();

        // Only load and close if it's not the active session
        if (!isActive) {
          controller.loadSessionHistory(sessionId);
        }

        // Always close history after tap
        controller.closeHistory();
      },
      onLongPress: () => _showDeleteDialog(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          boxShadow: [AppColors.shadowMedium],
          border: Border.all(
            color: isActive ? AppColors.funmint : AppColors.neutral200,
          ),
          color: isActive ? const Color(0xffDDF5F7) : AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.heading4.copyWith(
                  color: AppColors.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: isActive ? 16 : 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isActive)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffF8AD7F), Color(0xffFCCA6F)],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _DeleteSessionDialog(
        sessionId: sessionId,
        title: title,
        parentContext: context,
      ),
    );
  }
}

/// Delete confirmation dialog - positioned above slider
class _DeleteSessionDialog extends StatelessWidget {
  final String sessionId;
  final String title;
  final BuildContext parentContext;

  const _DeleteSessionDialog({
    required this.sessionId,
    required this.title,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Chat',
              style: AppTypography.heading3.copyWith(
                color: AppColors.onBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete this chat?',
              style: AppTypography.small.copyWith(color: AppColors.neutral700),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: AppTypography.heading3.copyWith(
                      color: AppColors.neutral600,
                      fontSize: 18,
                    ),
                  ),
                ),
                Consumer<ChatController>(
                  builder: (context, controller, child) {
                    return GestureDetector(
                      onTap: controller.isDeletingSession
                          ? null
                          : () async {
                              final success = await controller.deleteSession(
                                sessionId,
                              );
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                if (success) {
                                  _showSuccessSnackbar(parentContext);
                                }
                              }
                            },

                      child: controller.isDeletingSession
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Delete',
                              style: AppTypography.heading3.copyWith(
                                color: AppColors.error,
                                fontSize: 18,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    final overlay = Overlay.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.75;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        right: 10,
        width: drawerWidth - 40,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.funmint,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [AppColors.shadowMedium],
            ),
            child: Row(
              children: [
                Text(
                  'Chat deleted successfully',
                  style: AppTypography.small.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

/// Empty state with search support
class _EmptyState extends StatelessWidget {
  final bool isSearching;

  const _EmptyState({this.isSearching = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            isSearching ? 'No chats found' : 'No chat history yet',
            style: AppTypography.small.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isSearching)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Try a different search term',
                style: AppTypography.small.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Loading indicator
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      ),
    );
  }
}
