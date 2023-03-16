import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/view/transactions/add_transaction/add_transactions.dart';
import 'package:money_saver/core/styles.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openElevation: 30,
      closedElevation: 30,
     
        transitionDuration: const Duration(milliseconds: 600),
        openBuilder: (context, _) => const AddTransastion(),
        closedShape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
       
        closedBuilder: (context, openContainer) => Container(
          decoration: BoxDecoration(
          
            
            color: greenShade,
          ),
          height: 55,
          width:55,
          child:  Icon(
            Icons.add,
            color:whiteShade,
            size: 40,
          ),
        ),
      );
  }
}