import "dart:convert";

import 'package:flutter/material.dart';
import 'package:kaskai/constants/app_colors.dart';
import 'package:kaskai/constants/ui_constants.dart';
import 'package:kaskai/widgets/chat_message.dart';
import 'package:kaskai/widgets/feature_tile.dart';
import 'package:kaskai/widgets/input_field.dart';
import 'package:kaskai/widgets/platform_bottom_sheet.dart';
import 'package:lucide_icons/lucide_icons.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

final List<Map<String, dynamic>> features = [
  {
    "icon": "✨",
    "title": "Intelligence",
    "subtitle":
        "Kaskai is an Artificial Intelligence, trained by Kologsoft using Google Gemini AI to be safe, accurate, and secure — the best assistant for you to do your best work.",
  },
  {
    "icon": "✨",
    "title": "Capabilities",
    "subtitle":
        "If you can dream it, Kaskai can help you do it. Kaskai can process large amounts of information, brainstorm ideas, generate text and code, help you understand subjects, coach you through difficult situations, help simplify your busywork so you can focus on what matters most, and so much more.",
  },
  {
    "icon": "⚠️",
    "title": "Limitations",
    "subtitle":
        "As an AI chatbot, Kaskai can't guarantee the integrity of information provided. Make sure to verify information and responses provided.",
  },
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController chatController;
  late bool isLoading;
  final List<Map<String, dynamic>> chatMessages = [];

  Future<void> sendMessage(String message) async {
    final url =
        Uri.parse("https://us-central1-heritageaskets.cloudfunctions.net/chat");
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "data": {"text": message}
    });

    setState(() {
      chatMessages.add({"sender": "user", "message": message});
      _saveMessages();
    });

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData != null &&
            responseData['result'] != null &&
            responseData['result']['candidates'] != null &&
            responseData['result']['candidates'][0] != null &&
            responseData['result']['candidates'][0]['content'] != null &&
            responseData['result']['candidates'][0]['content']['parts'] !=
                null &&
            responseData['result']['candidates'][0]['content']['parts'][0] !=
                null &&
            responseData['result']['candidates'][0]['content']['parts'][0]
                    ['text'] !=
                null) {
          final botMessage = responseData['result']['candidates'][0]['content']
              ['parts'][0]['text'];
          debugPrint(botMessage);
          setState(() {
            chatMessages.add({"sender": "bot", "message": botMessage});
            _saveMessages();
          });
        } else {
          setState(() {
            chatMessages.add(
                {"sender": "bot", "message": "Error: Invalid response format"});
            _saveMessages();
          });
        }
      } else {
        setState(() {
          chatMessages.add(
              {"sender": "bot", "message": "Error: ${response.statusCode}"});
          _saveMessages();
        });
      }
    } catch (e) {
      setState(() {
        chatMessages.add({"sender": "bot", "message": "An error occurred: $e"});
        _saveMessages();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    chatController = TextEditingController();
    isLoading = false;
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages = prefs.getStringList('messages') ?? [];
    setState(() {
      chatMessages.addAll(
        messages
            .map((message) => json.decode(message))
            .toList()
            .cast<Map<String, dynamic>>(),
      );
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages =
        chatMessages.map((message) => json.encode(message)).toList();
    prefs.setStringList('messages', messages);
  }

  var isDesktop = ScreenSize.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: Scaffold(
        appBar: appbar(context),
        drawer: isDesktop ? null : modileDrawer(theme),
        endDrawer: isDesktop ? desktopAccountDrawer(theme) : null,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/332566805_761706799008722_5072373374661712269_n.webp",
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            Container(
              color: Colors.white54,
            ),
            Row(
              children: [
                isDesktop ? desktopSidebar(theme) : Container(),
                Flexible(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      // color: theme.colorScheme.background,
                      padding: EdgeInsets.all(Sizes.base),
                      width: ScreenSize.width,
                      constraints: const BoxConstraints(
                        maxWidth: 960,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: chatMessages.isNotEmpty
                                ? chatList(theme)
                                : introduction(theme),
                          ),
                          inputField(theme),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputField inputField(ThemeData theme) {
    return InputField(
      isLoading: isLoading,
      controller: chatController,
      hintText: "Chat Kaskai",
      prefixIcon: IconButton(
        onPressed: () {},
        icon: const Icon(LucideIcons.mic),
      ),
      suffixIcon: FloatingActionButton.small(
        enableFeedback: !isLoading,
        elevation: 0.0,
        onPressed: () {
          if (!isLoading && chatController.text.isNotEmpty) {
            sendMessage(chatController.text);
            chatController.clear();
          } else {
            null;
          }
        },
        child: isLoading
            ? const Icon(
                LucideIcons.stopCircle,
              )
            : const Icon(
                LucideIcons.send,
              ),
      ),
      onFieldSubmitted: (value) {
        if (!isLoading && chatController.text.isNotEmpty) {
          sendMessage(chatController.text);
          chatController.clear();
        } else {
          null;
        }
      },
    );
  }

  Center introduction(ThemeData theme) {
    return Center(
      child: Column(
        children: [
          Text(
            "Welcome to Kaskai",
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          Spacing.verticalSpacingSm,
          Text(
            "Kaskai is a next generation AI assistant built to provide instant answers, helpful recommendations and engaging conversations",
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Spacing.verticalSpacingXl,
          Spacing.verticalSpacingXl,
          Container(
            constraints: const BoxConstraints(maxWidth: 768),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: features.length,
              separatorBuilder: (context, index) => Spacing.verticalSpacingLg,
              itemBuilder: (ctx, idx) => FeatureTile(
                icon: features[idx]["icon"],
                title: features[idx]["title"],
                subtitle: features[idx]["subtitle"],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView chatList(ThemeData theme) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: Sizes.xl),
      separatorBuilder: (context, index) => Spacing.verticalSpacingLg,
      itemCount: chatMessages.length,
      itemBuilder: (context, index) {
        final message = chatMessages[index];
        final bool isNewMessage =
            chatMessages.indexOf(message) >= chatMessages.length - 1;
        return ChatMessage(
          sender: message["sender"],
          message: message,
          isNewMessage: isNewMessage,
        );
      },
    );
  }

  Widget modileDrawer(ThemeData theme) {
    return Drawer(
      child: SafeArea(
        child: chatHistory(theme),
      ),
    );
  }

  Widget chatHistory(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.base),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Sizes.xl * 1.5,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.colorScheme.primary),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {},
                  icon: const Icon(LucideIcons.plus),
                  label: const Text(
                    "New chat",
                  ),
                ),
              )
            ],
          ),
          Spacing.verticalSpacing,
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 3,
              separatorBuilder: (context, index) => Spacing.verticalSpacingSm,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                style: ListTileStyle.drawer,
                title: Text(
                  "Introduction",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontFamily: "GT Walsheim Pro"),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desktopAccountDrawer(ThemeData theme) {
    return Drawer(
      width: ScreenSize.width / 4,
      child: profileContent(theme),
    );
  }

  AppBar appbar(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      centerTitle: false,
      leading: isDesktop
          ? null
          : Builder(builder: (context) {
              return IconButton(
                icon: const Icon(LucideIcons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
      title: RichText(
        text: TextSpan(
          text: "Kask",
          children: [
            TextSpan(
              text: "ai",
              style: TextStyle(color: theme.colorScheme.primary),
            )
          ],
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: isDesktop
                ? () => Scaffold.of(context).openEndDrawer()
                : () => showModalBottomSheet(
                      context: context,
                      builder: (context) => profileSheet(theme),
                    ),
            icon: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Center(
                child: Text(
                  "K",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget profileSheet(ThemeData theme) {
    return PlatformBottomSheet(
      content: [
        profileContent(theme),
      ],
    );
  }

  Column profileContent(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundColor: theme.colorScheme.surface,
          ),
          accountName: Text("Kologsoft", style: theme.textTheme.titleLarge),
          accountEmail: Text(
            "kaskai@kologsoft.com",
            style: theme.textTheme.bodyLarge!
                .copyWith(color: theme.colorScheme.outline),
          ),
          decoration: BoxDecoration(borderRadius: Corners.baseBorder),
        ),
        Spacing.verticalSpacing,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Sizes.xl * 1.5,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColours.dangerLight),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {},
                icon: Icon(
                  LucideIcons.logOut,
                  size: Sizes.base,
                ),
                label: Text(
                  "Sign out",
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Spacing.verticalSpacingMed,
      ],
    );
  }

  Container desktopSidebar(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.base),
      constraints: const BoxConstraints(
        maxWidth: 288,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.inputDecorationTheme.fillColor!,
          ),
        ),
      ),
      child: chatHistory(theme),
    );
  }
}
