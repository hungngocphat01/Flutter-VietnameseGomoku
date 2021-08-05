Product under development.

# Introduction
This is a simple Gomoku game (Vietnamese variant - "cờ carô") written in Flutter.

Rule: the winner must have an overline or an unbroken row of five stones that is not blocked at either end (overlines are immune to this rule). <br>

![demo](extra/demo.gif)

# Class diagram
I have a habit of drawing a diagram to keep track where everything are. Fortunately, I have just finished OOP in  uni, so with this project I keep a copy of its class diagram (simplified). <br>
I'm not too familiar with design patterns, so I made up this structure without any explicit reference to any design pattern, so don't be surprised if it's too bad.
![class-diagram](extra/ClassDiagram.jpg)

# Implementation note
# Program flow
1. `main()` initializes a `MaterialApp` object, which then creates a `HomescreenRoute`, eventually becoming the home widget.
2. `HomescreenRoute` asks the user to specify dimensions for the game board. The results are saved to the `globals` library.
3. After the "Play" button is clicked, a new `GameplayRoute` is created and laid out to the UI.
4. `GameplayRoute`'s build method returns a `Scaffold`, whose body is an instance of `GameBoard`.
5. `-GameboardState` reads the board dimensions from `globals` and initalizes a grid of `BoardCell`s accordingly. If the cells are too small to be playable, an exception will be raised and the program will return back to `HomescreenRoute`.

## Handling user click on the `BoardCell`s
The `build` method of `_BoardCellState` returns a `GestureDetector`, whose `onTap` property points to the `_BoardCellState.onUserClick` function.
1. When user clicks on `BoardCell`, `_BoardCellState.onUserClick()` method is invoked.
2. The method searchs for the nearest (and only) `_GameboardState` up in the widget tree.
3. The method calls the `_GameboardState.handleUserClick(int, int)` method from its parent.
4. The parent `_GameboardState` now has received the call from its child. Now it should notify the caller the current player of the game (player 1 or player 2) ("passed" through its return value).
5. The calling `_BoardCellState` now knows which player is playing and it should lock its state to prevent further changes, as well as displaying an `O` or `X` mark accordingly to the current player.

6. `_GameboardState` passes the location of the just clicked cell in the Gameboard to `GameProcessor`.
7. `GameProcessor` should process the incoming information and returns a `TurnMessenger` object.
8. `_GameboardState` receives the response from `GameProcessor` and should whether decide to do the following things if the game has finished:
    - Lock the Gameboard.
    - Mark the cells.
    - Show the winner's name.
