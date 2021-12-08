import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';




class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation='0';
  String result='0';
  String expression='';


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title:Text('Calculator'),centerTitle: true,),
      body: Column(
        children: [
          Container(
            color: Color(0xF5F2F2FF),
            // padding: EdgeInsets.symmetric(horizontal: size.width*0.07,vertical: size.height*0.03),
            alignment: Alignment.centerRight,
            child: Text(equation,style: TextStyle(fontSize: size.height*0.06),maxLines: 1,),
          ),
          Divider(),
          Container(
            color: Color(0xFCFCFCFF),
            // padding: EdgeInsets.symmetric(horizontal: size.width*0.07,vertical: size.height*0.03),
            alignment: Alignment.centerRight,
            child: Text(result,style: TextStyle(fontSize: size.height*0.05),maxLines: 1,),
          ),
          Divider(),
          Row(
            children: [
              Container(
                width: size.width*.75,
                //color: Colors.green,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildBtn('C',1.0,Color(0x1267FCFF),Colors.white),
                          buildBtn('AC',1.0,Color(0xD6DBD6FF),Colors.white),
                          buildBtn('÷',1.0,Color(0xD6DBD6FF),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('7',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('8',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('9',1.0,Color(0xFFFFFFFD),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('4',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('5',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('6',1.0,Color(0xFFFFFFFD),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('1',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('2',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('3',1.0,Color(0xFFFFFFFD),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('.',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('0',1.0,Color(0xFFFFFFFD),Colors.white),
                          buildBtn('00',1.0,Color(0xFFFFFFFD),Colors.white),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width*.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildBtn('×',1.0,Color(0xD6DBD6FF),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('-',1.0,Color(0xD6DBD6FF),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('+',1.0,Color(0xD6DBD6FF),Colors.white),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildBtn('=',2.0,Color(0xD6DBD6FF),Colors.white),
                        ]
                    ),
                  ],
                ),
              )

            ],
          )

        ],
      ),


    );
  }

  Widget buildBtn(String btnText,double btnHeight,Color btnColor,Color shapColor){
    Size size=MediaQuery.of(context).size;
    return Container(

      height: size.height*.1*btnHeight,

      decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(40)
      ),
      child: FlatButton(
        onPressed: (){
          setState(() {
            if(btnText=='C'){
              equation='0';
              result='0';
            }
            else if(btnText=='AC'){
              equation=equation.substring(0,equation.length-1);
              if(equation==''){
                equation='0';
              }
            }
            else if(btnText=='='){
              expression=equation;
              expression=expression.replaceAll('×', '*');
              expression=expression.replaceAll('÷', '/');
              try{
                Parser p=Parser();
                Expression exp=p.parse(expression);
                ContextModel cm=ContextModel();
                result='${exp.evaluate(EvaluationType.REAL, cm)}';
              }catch(e){
                result='error';
              }
            }
            else{

              if(equation=='0'){
                equation=btnText;
              }
              else
              {
                equation+=btnText;
              }
            }

          });
        },
        child: Text(btnText,style: TextStyle(fontSize: size.height*0.06),),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: shapColor,
                width: 1,
                style: BorderStyle.solid
            )
        ),

      ),
    );
  }
}