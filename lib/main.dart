/* Build a calculator app that can perform basic arithmetic operations. */
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',

      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables
  double number1=0.0;
  double number2=0.0;
  var input ='';
  var output ='';
  var operation ='';
  var sizeChange = false;
  var outputSize=45.0;
  var inputSize=35.0;
  //method
  onButtonClick(value){

    //value is AC
   if(value=="AC"){
     input='';
     output='';
   }

   //value is ⌫
   else if(value=="\u232b"){
     if(input.isNotEmpty){
      input=input.substring(0,input.length-1);}
   }

   //value is =
    else if(value=="="){
     if(input.isNotEmpty) {

       var userInput = input;
       userInput = input.replaceAll("x", "*");
       Parser p = Parser();
       Expression expression = p.parse(userInput);
       ContextModel contextModel = ContextModel();
       var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
       output = finalValue.toString();
       if(output.endsWith(".0")) {
         output = output.substring(0, output.length - 2);
       }
       input = output;
       sizeChange=true;
     }
   }

    //valuse is other
    else{
      if(value=="%" || value=="/" || value=="+" || value=="-" || value=="x" || value==".") {
        if(input.isNotEmpty) {
          input = input + value;
        }
      }
      else{
        input = input + value;
      }
   }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(

        backgroundColor:Colors.black,

      ),
      body:
      Column(
        children: [

          //input-output area
          Expanded(child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            color: Colors.black12,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
                 Text(input,style: TextStyle(fontSize: sizeChange ? inputSize:48,color: Colors.white),),
                 SizedBox(height: 25,),
                 Text(output,style: TextStyle(fontSize: sizeChange ? outputSize:35,color: Colors.white),),
                 SizedBox(height: 30,),
             ],
           ),
          )),


          //buttons area
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(text: "AC",buttonBgcolor: Colors.white10),
              elevatedButton(text: "%",buttonBgcolor: Colors.white10),
              elevatedButton(text: "\u232b",buttonBgcolor: Colors.white10),
              elevatedButton(text: "/",buttonBgcolor: Colors.white10),
            ],//children
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(text: "7"),
              elevatedButton(text: "8"),
              elevatedButton(text: "9"),
              elevatedButton(text: "x",buttonBgcolor: Colors.white10),

            ],//children
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(text: "4"),
              elevatedButton(text: "5"),
              elevatedButton(text: "6"),
              elevatedButton(text: "-",buttonBgcolor: Colors.white10),

            ],//children
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(text: "1"),
              elevatedButton(text: "2"),
              elevatedButton(text: "3"),
              elevatedButton(text: "+",buttonBgcolor: Colors.white10),

            ],//children
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              elevatedButton(text: "00"),
              elevatedButton(text: "0"),
              elevatedButton(text: "."),
              elevatedButton(text: "=",buttonBgcolor: Colors.indigo),

            ],//children
          )

        ],//children

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //elevatedButton function
  Widget elevatedButton({
    text,tscolor = Colors.white,buttonBgcolor = Colors.white24
}){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: buttonBgcolor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                padding: const EdgeInsets.all(22), // Adjust padding to fit the circle
              ),

              onPressed: () => onButtonClick(text),
              child: Text(text,style: TextStyle(
              fontSize: 28,
              color: tscolor,
              fontWeight: FontWeight.bold
          ),)
          ),


      ),
    );
  }

}
