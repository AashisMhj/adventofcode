import 'dart:io';

/*
1+3 = 4
2+6 = 8
3+0 = 3
1+0 = 1
2+3 = 5
3+6 = 9
1+6 = 7
2+0 = 2
3+3 = 6
*/

/*
x- loose
y- draw
z- win
AX - loose, scissor, 0+3 = 3
AY - draw, rock, 3+1 = 4
AZ - win, paper, 6 + 2 = 8
BX - loose, rock, 0+1 = 1
BY - draw, paper, 3+2 = 5
BZ - win, scissor, 6+3 = 9
CX - loose, paper, 0+2 = 2
CY - draw, scissor, 3+3 = 6
CZ - win, rock, 6+1 = 7
*/

const result = <String, int>{
  "AX": 4,
  "AY": 8,
  "AZ": 3,
  "BX": 1,
  "BY": 5,
  "BZ": 9,
  "CX": 7,
  "CY": 2,
  "CZ": 6
};

const result2 = <String, int>{
"AX" : 3,
"AY" : 4,
"AZ" : 8,
"BX" : 1,
"BY" : 5,
"BZ" : 9,
"CX" : 2,
"CY" : 6,
"CZ" : 7
};

void main() async {
  int total_score = 0;
  int total_score2 = 0;
  final file = await File('input.txt').readAsString();
  try {
    file.split("\n").forEach((element){
      String result_text = element.replaceAll(" ", "");
      int point = result[result_text] ?? 0;
      int point2 = result2[result_text] ?? 0;
      total_score += point;
      total_score2 += point2;
    });
    print('Total Score $total_score');
    print('Total Score 2: $total_score2');
  } catch (e) {
    
  }
}