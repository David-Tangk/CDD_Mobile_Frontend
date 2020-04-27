import 'package:cdd_mobile_frontend/common/api/api.dart';
import 'package:cdd_mobile_frontend/common/entity/entity.dart';
import 'package:cdd_mobile_frontend/common/util/util.dart';
import 'package:cdd_mobile_frontend/common/value/value.dart';
import 'package:cdd_mobile_frontend/global.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  APIResponse<UserInfoEntity> _apiResponse;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  _fetchUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await UserAPI.getUserInfo(int.parse(Global.accessToken));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 360,
                  backgroundColor: AppColor.primaryBackground,
                  floating: true,
                  pinned: false,
                  flexibleSpace: _buildUserHeader(),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconfont.bianji1),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  // 用户界面头部
  _buildUserHeader() {
    return ClipPath(
      clipper: UserBottomClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4a00e0).withOpacity(0.7),
          // gradient: LinearGradient(
          //   colors: [Color(0xFF4a00e0), Color(0xFF8e2de2)],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Container(
                width: cddSetWidth(100),
                height: cddSetWidth(100),
                child:
                    Image.network(_apiResponse.data.avatar, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: cddSetHeight(10)),
            Text(
              _apiResponse.data.nickname,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: cddSetFontSize(17),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: cddSetHeight(14)),
            Text(
              _apiResponse.data.introduction,
              style: TextStyle(
                color: Colors.black,
                fontSize: cddSetFontSize(15),
              ),
            ),
            SizedBox(height: cddSetHeight(34)),
            _buildUserState(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cddSetWidth(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUserStateItem("宠物", _apiResponse.data.petNumber, () {}),
          _buildUserStateItem("动态", _apiResponse.data.instantNumber, () {}),
          _buildUserStateItem("关注", _apiResponse.data.followNumber, () {}),
          _buildUserStateItem("粉丝", _apiResponse.data.fansNumber, () {}),
        ],
      ),
    );
  }

  Widget _buildUserStateItem(String title, int value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            "$value",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}