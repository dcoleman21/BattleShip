require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_cell_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_cell_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_cell_is_empty
    cell = Cell.new("B4")

    assert_equal nil, cell.ship
    assert_equal true, cell.empty?
  end

  def test_cell_can_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_instance_of Ship, cell.ship
    assert_equal false, cell.empty?
  end

  def test_cell_fired_upon_starts_false
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_cell_fired_upon_hits_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal 3, cell.ship.health

    cell.fire_upon

    assert_equal true, cell.fired_upon?
    assert_equal 2, cell.ship.health
  end
end
