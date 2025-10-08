import 'package:flutter/material.dart';
import 'package:jihc_landf/navBuild.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
              Stack(
                children: [
                Column(
                  children: [
                    Image.asset('assets/done.gif', width: screenWidth * 0.6),
                    Text('Congratulations \n on finding your item!',style: TextStyle(fontSize: 30),textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    Text('''The chat will be deleted and \n the item won't appear in feed''', textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.grey),)
                  ],
                ),
                
                   Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                     child: Container(
                      height: 80,
                      width: screenWidth * 0.9,
                       child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E92FF)
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBuild()));
                        }, 
                        child: Text('PROCEED', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 2,color: Colors.white),)
                        ),
                     ),
                   ),
                ],
              ),
                
              
              
            
          
    );
  }
}