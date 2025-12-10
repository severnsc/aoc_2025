require "test_helper"

class TileFloorTest < Minitest::Test
  def test_sets_red_tile_coordinates
    tile_floor = TileFloor.new [Point.new(x: 0, y: 0, z: 0)]

    assert_equal [Point.new(x: 0, y: 0, z: 0)], tile_floor.red_tile_coordinates
  end
end
