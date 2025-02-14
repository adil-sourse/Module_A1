import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/screens/auth/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Профиль')),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  CupertinoIcons.profile_circled,
                  color: CupertinoColors.black,
                  size: 140,
                ),
              ),
            ),
            Center(
              child: Text(
                'sad',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'asd',
                style: const TextStyle(
                    fontSize: 18, color: CupertinoColors.systemGrey),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: CupertinoButton(
                  color: CupertinoColors.destructiveRed,
                  child: const Text(
                    'Выйти',
                    style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _logout(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
