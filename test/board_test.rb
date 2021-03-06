require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require "pry"

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new
    assert_equal 16, board.cells.count
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2",
    "C3", "C4", "D1", "D2", "D3", "D4"], board.cells.keys
    assert_equal Hash, board.cells.class
    assert_equal Cell, board.cells.values[0].class
    assert_equal Cell, board.cells.values[1].class
    assert_equal Cell, board.cells.values[2].class
    assert_equal Cell, board.cells.values[3].class
    assert_equal Cell, board.cells.values[4].class
    assert_equal Cell, board.cells.values[5].class
    assert_equal Cell, board.cells.values[6].class
    assert_equal Cell, board.cells.values[7].class
    assert_equal Cell, board.cells.values[8].class
    assert_equal Cell, board.cells.values[9].class
    assert_equal Cell, board.cells.values[10].class
    assert_equal Cell, board.cells.values[11].class
    assert_equal Cell, board.cells.values[12].class
    assert_equal Cell, board.cells.values[13].class
    assert_equal Cell, board.cells.values[14].class
    assert_equal Cell, board.cells.values[15].class
  end

  def test_there_are_valid_coordinates
    board = Board.new
    board.cells

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal true, board.valid_coordinate?("A2")

    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")

  end

  def test_ship_length_matches_coordinate_size
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement_length?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement_length?(submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_have_valid_placement
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_coordinates_are_diagonal
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.diagonal_coordinates?(cruiser, ["A1", "B2", "C3"])
    assert_equal true, board.diagonal_coordinates?(submarine, ["C2", "D3"])
  end

  def test_valid_placement_invalid_if_diagonal
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_coordinates_have_consecutive_placements
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.consecutive_placements?(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.consecutive_placements?(submarine, ["A1", "C1"])
  end

  def test_place_ships
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship

    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_cannot_overlap
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.overlap?(submarine, ["B1", "B2"])
  end

  def test_contains_ship
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.contains_ship?(submarine, ["A1", "A2"])

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal true, board.contains_ship?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.contains_ship?(cruiser, ["A1", "B1", "C1"])

    assert_equal false, board.contains_ship?(cruiser, ["B1", "C1", "D1"])
  end

  def test_board_can_render
    require './lib/board'
    require './lib/ship'
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render

    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end
end
