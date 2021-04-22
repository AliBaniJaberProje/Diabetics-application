import 'package:flutter/material.dart';

class ImgView extends StatelessWidget {
  final String index;

  const ImgView({this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text("Item #$index"),
              background: Hero(
                tag: "avatar-$index",
                child: Image.network(
                  this.index.toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes !=
                            null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


