import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  @override
  _GameBoardScreenState createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  List<String> _gameValues = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  bool _xTurn = true;
  int _filledBoxes = 0;

  ///PLAYERS SCORES
  int _xPlayerScore = 0;
  int _oPlayerScore = 0;

  void _buttonTapped(index) {
    setState(() {
      if (_xTurn && _gameValues[index] == '') {
        _gameValues[index] = 'X';
        _filledBoxes++;
      } else if (!_xTurn && _gameValues[index] == '') {
        _gameValues[index] = 'O';
        _filledBoxes++;
      }
      _xTurn = !_xTurn;
      _checkWinner();
    });
    print('tapped $index - xTurn: $_xTurn');
  }

  void _checkWinner() {
    /// 0 == 1 == 2
    if (_gameValues[0] != '' &&
        (_gameValues[0] == _gameValues[1] &&
            _gameValues[0] == _gameValues[2])) {
      _showWinnerDialog(_gameValues[0]);
    }

    /// 0 == 3 == 6
    else if (_gameValues[0] != '' &&
        (_gameValues[0] == _gameValues[3] &&
            _gameValues[0] == _gameValues[6])) {
      _showWinnerDialog(_gameValues[0]);
    }

    /// 3 == 4 == 5
    else if (_gameValues[3] != '' &&
        (_gameValues[3] == _gameValues[4] &&
            _gameValues[3] == _gameValues[5])) {
      _showWinnerDialog(_gameValues[3]);
    }

    /// 6 == 7 == 8
    else if (_gameValues[6] != '' &&
        (_gameValues[6] == _gameValues[7] &&
            _gameValues[6] == _gameValues[8])) {
      _showWinnerDialog(_gameValues[6]);
    }

    /// 1 == 4 == 7
    else if (_gameValues[1] != '' &&
        (_gameValues[1] == _gameValues[4] &&
            _gameValues[1] == _gameValues[7])) {
      _showWinnerDialog(_gameValues[1]);
    }

    /// 2 == 5 == 8
    else if (_gameValues[2] != '' &&
        (_gameValues[2] == _gameValues[5] &&
            _gameValues[2] == _gameValues[8])) {
      _showWinnerDialog(_gameValues[2]);
    }

    /// 0 == 4 == 8
    else if (_gameValues[0] != '' &&
        (_gameValues[0] == _gameValues[4] &&
            _gameValues[0] == _gameValues[8])) {
      _showWinnerDialog(_gameValues[0]);
    }

    /// 2 == 4 == 6
    else if (_gameValues[2] != '' &&
        (_gameValues[2] == _gameValues[4] &&
            _gameValues[2] == _gameValues[6])) {
      _showWinnerDialog(_gameValues[2]);
    }

    /// Draw
    else if (_filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  ///WINNER DIALOG
  void _showWinnerDialog(String player) {
    ///increase winner score
    if (player == 'X') {
      _xPlayerScore += 1;
    } else {
      _oPlayerScore += 1;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Player $player wins'),
        content: Text('Play again!'),
        actions: [
          TextButton(
            onPressed: () {
              _clearBoard();
              Navigator.of(context).pop();
            },
            child: Text('Play again'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _xPlayerScore = 0;
                _oPlayerScore = 0;
                _xTurn = true;
                _filledBoxes = 0;
                for (int indx = 0; indx < _gameValues.length; indx++) {
                  _gameValues[indx] = '';
                }
              });
              Navigator.of(context).pop();
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  ///DRAW DIALOG
  void _showDrawDialog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('No one wins!'),
          content: Text('Play again!'),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play again'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _xPlayerScore = 0;
                  _oPlayerScore = 0;
                  _xTurn = true;
                  _filledBoxes = 0;
                  for (int indx = 0; indx < _gameValues.length; indx++) {
                    _gameValues[indx] = '';
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            ),
          ],
        ),
      );

  ///CLEAR BOARD
  void _clearBoard() {
    setState(() {
      // _gameValues = [
      //   '',
      //   '',
      //   '',
      //   '',
      //   '',
      //   '',
      //   '',
      //   '',
      //   '',
      // ];
      _filledBoxes = 0;
      for (int indx = 0; indx < _gameValues.length; indx++) {
        _gameValues[indx] = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Player X',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$_xPlayerScore',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Player O',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$_oPlayerScore',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _buttonTapped(index),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _gameValues[index],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
