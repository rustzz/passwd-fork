import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../redux/actions/sync.dart';

class SyncAuthScreen extends StatefulWidget {
  final bool register;

  SyncAuthScreen({this.register = false});

  @override
  _SyncAuthScreenState createState() => _SyncAuthScreenState();
}

class _SyncAuthScreenState extends State<SyncAuthScreen> {
  bool isUrlValid = false;
  bool isSecretValid = false;
  bool isUsernameValid = false;
  bool isPasswordValid = false;

  TextEditingController urlController = TextEditingController();
  TextEditingController secretController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final urlRegex = RegExp(
      '((http|https)://)[a-zA-Z0-9@:%._\\+~#?&//=]{1,256}',
      caseSensitive: true,
      dotAll: true,
    );

    urlController.addListener(() {
      setState(() {
        try {
          isUrlValid = urlRegex.hasMatch(urlController.text);
        } catch (e) {
          isUrlValid = false;
        }
      });
    });

    secretController.addListener(() {
      setState(() {
        isSecretValid = secretController.text.isNotEmpty;
      });
    });

    usernameController.addListener(() {
      setState(() {
        isUsernameValid = usernameController.text.length > 3;
      });
    });

    passwordController.addListener(() {
      setState(() {
        isPasswordValid = passwordController.text.length > 7;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          !widget.register
              ? context.getString('login')
              : context.getString('register'),
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            onPressed: isSecretValid &&
                    isUrlValid &&
                    isUsernameValid &&
                    isPasswordValid
                ? () async {
                    // ignore: unawaited_futures
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        title: Text(context.getString('please_wait')),
                        content: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    );

                    try {
                      final uri = Uri.parse(urlController.text);
                      final secret = secretController.text;
                      final username = usernameController.text;
                      final password = passwordController.text;

                      // TODO: handle errors
                      if (widget.register) {
                        await Provider.of<DispatchFuture>(context,
                            listen: false)(
                          RegisterAction(uri, secret, username, password),
                        );
                      }

                      await Provider.of<DispatchFuture>(context, listen: false)(
                        LoginAction(uri, secret, username, password),
                      );

                      Provider.of<Dispatch>(context, listen: false)(
                        LoginStateAction(true),
                      );

                      await Provider.of<DispatchFuture>(context, listen: false)(
                        PushEntriesAction(),
                      );

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();

                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => AlertDialog(
                          title: Text(widget.register
                              ? context.getString('registration_failed')
                              : context.getString('login_failed')),
                        ),
                      );

                      print(e);
                    }
                  }
                : null,
            tooltip: context.getString('done_tooltip'),
            icon: Icon(Feather.check_circle),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: context.getString('server_url').toUpperCase(),
                errorText:
                    isUrlValid ? null : context.getString('server_url_invalid'),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.url,
              onFieldSubmitted: (val) {
                // usernameFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: secretController,
              decoration: InputDecoration(
                labelText: context.getString('server_secret').toUpperCase(),
                errorText: isSecretValid
                    ? null
                    : context.getString('server_secret_invalid'),
              ),
              // focusNode: usernameFocus,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                // passwordFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: context.getString('username').toUpperCase(),
                errorText: isUsernameValid
                    ? null
                    : context.getString('username_invalid'),
              ),
              // focusNode: passwordFocus,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                // notesFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: context.getString('password').toUpperCase(),
                errorText: isPasswordValid
                    ? null
                    : context.getString('password_invalid'),
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {},
            ),
            SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () {
                secretController.text = 'demo';
                urlController.text = 'https://demo.passwd.rustzzdev.ru';
              },
              child: Text(context.getString('use_demo_server')),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    urlController.dispose();
    secretController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
