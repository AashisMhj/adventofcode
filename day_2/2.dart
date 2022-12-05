import 'dart:async';
import 'dart:io';
enum options_enum{
  rock,
  paper,
  scissors
}
enum possible_outcome{
  win,
  draw,
  loose
}

const outcome_point = <possible_outcome, int>{
  possible_outcome.win: 6,
  possible_outcome.draw: 3,
  possible_outcome.loose: 0
};
const options_value = <options_enum, int>{
  options_enum.rock: 1,
  options_enum.paper: 2,
  options_enum.scissors: 3
};
const opponent_dict = <String, options_enum>{
  "A": options_enum.rock,
  "B": options_enum.paper,
  "C": options_enum.scissors
};
const user_dict = <String, options_enum>{
  "X": options_enum.rock,
  "Y": options_enum.paper,
  "Z": options_enum.scissors
};

const result = <String, possible_outcome>{
  "AX": possible_outcome.draw,
  "AY": possible_outcome.win,
  "AZ": possible_outcome.loose,
  "BX": possible_outcome.loose,
  "BY": possible_outcome.draw,
  "BZ": possible_outcome.win,
  "CX": possible_outcome.win,
  "CY": possible_outcome.loose,
  "CZ": possible_outcome.draw
};
// for task 2
const user_dict2 = <String, possible_outcome>{
  "X": possible_outcome.loose,
  "Y": possible_outcome.draw,
  "Z": possible_outcome.win
};
const result2 = <String, options_enum>{
  "AX": options_enum.scissors,
  "AY": options_enum.rock,
  "AZ": options_enum.paper,
  "BX": options_enum.rock,
  "BY": options_enum.paper,
  "BZ": options_enum.scissors,
  "CX": options_enum.paper,
  "CY": options_enum.scissors,
  "CZ": options_enum.rock
};
int getPoint(options_enum? selected_option, possible_outcome? result_outcome){
  var point_from_option = options_value[selected_option] ?? 0 ;
  int point_from_result = outcome_point[result_outcome]  ?? 0;
  return  point_from_option+point_from_result ;
}



void main() async {
  int total_score = 0;
  int total_score2 = 0;
  final file = await File('input.txt').readAsString();
  try {
  file.split("\n").forEach((element) {
    var selected_plays = element.split(" ");
    if(selected_plays.length >= 2){
      String first_string = selected_plays[0];
      String second_string = selected_plays[1];
      possible_outcome? match_result = result['$first_string$second_string'];
      total_score += getPoint(user_dict[second_string], match_result);
      //
      options_enum? user_pick = result2['$first_string$second_string'];
      total_score2 += getPoint(user_pick, user_dict2[second_string]);
    }
  });
  print('Total Score: $total_score');
  print('Total Score : $total_score2');
    
  } catch (e) {
    print("Error");
  }

}



// void main() {
//   int total_score = 0;
//   File('input2.txt').readAsString().then((String value) => {
//     value.split("\n").forEach((element) {
//       var selected_plays = element.split(" ");
//       if(selected_plays.length >= 2){
//         String opponent_pick = selected_plays[0];
//         String user_pic = selected_plays[1];
//         possible_outcome? match_result = result['$opponent_pick$user_pic'];
//         total_score += getPoint(user_dict[user_pic], match_result);
//       }
//     });
//     print('Total Score: $total_score');
//   })
//   .catchError(( error){
//     print("Error Reading file");
//     print(error.toString());
//   });
  
// }