import 'package:flutter/material.dart';
import 'package:jihc_landf/navBuild.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Congratulations on finding your item!'),
          ),
          Positioned(
            bottom: 10,
            child: 

                Container(
                  width: double.infinity,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBuild()));
                    }, 
                    child: Text('PROCEED')
                  ),
                )
            
          )
        ],
      )
    );
  }
}