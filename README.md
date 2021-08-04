# Introduction
This is a simple Gomoku game (Vietnamese variant - "cờ carô") written in Flutter. Still under development.<br>

Rule: the winner must have an overline or an unbroken row of five stones that is not blocked at either end (overlines are immune to this rule). <br>

I'm not too familiar with design patterns, so I made up this structure without any reference to any design pattern, so don't be surprised if it's too bad.
![class-diagram](extra/ClassDiagram.jpg)

# Implementation note
## UI Preparation 
1. `_GameplayRouteState`'s build method is called.
2. It returns a `Chessboard`. A `_ChessboardState` instance is created inside `Chessboard`. (`rownum`, `colnum` should be passed).
3. The `_ChessboardState`'s build method is called. It then initializes a grid of `ChessboardCell`s (`rowpos`, `colpos` should be passed).
4. The `ChessboardCell`s are created and drawn onto the UI.

## Handling user click on the `ChessboardCell`s
The `build` method of `_ChessboardCellState` returns a `GestureDetector`, whose `onTap` property points to the `_ChessboardCellState.onUserClick` function.
1. When user clicks on `ChessboardCell`, `_ChessboardCellState.onUserClick()` method is invoked.
2. The method searchs for the nearest (and only) `_ChessboardState` up in the widget tree.
3. The method calls the `_ChessboardState.handleUserClick(int, int)` method from its parent.
4. The parent `_ChessboardState` now has received the call from its child. Now it should notify the caller the current player of the game (player 1 or player 2) ("passed" through its return value).
5. The calling `_ChessboardCellState` now knows which player is playing and it should lock its state to prevent further changes, as well as displaying an `O` or `X` mark accordingly to the current player.

6. `_ChessboardState` passes the location of the just clicked cell in the chessboard to `GameProcessor`.
7. `GameProcessor` should process the incoming information and returns a `TurnMessenger` object.
8. `_ChessboardState` receives the response from `GameProcessor` and should whether decide to do the following things if the game has finished:
    - Lock the chessboard.
    - Mark the cells.
    - Show the winner's name.