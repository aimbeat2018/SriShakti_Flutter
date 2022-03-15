import 'package:flutter/material.dart';
import '../../models/live_tv_details_model.dart';

class LiveTvChannelsCard extends StatelessWidget {
  static final String route = '/LiveTvChannelsCard';

  final AllTvChannel? allTvChannel;
  const LiveTvChannelsCard({Key? key, this.allTvChannel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 140,
      margin: EdgeInsets.only(right: 2),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0)),
                  child: Image.network(
                    allTvChannel!.posterUrl!,
                    fit: BoxFit.cover,
                    height: 60,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  padding: EdgeInsets.only(left: 2, right: 2),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allTvChannel!.tvName!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}