defmodule SamplePlotAppTest do
  use ExUnit.Case
  doctest SamplePlotApp

  test "sample_parse" do
    IO.puts "sample_parse"
    IO.inspect Plot.parse("""
      {game {
          id
        }}
      """)
  end

  test "sample_parse_and_generate" do
    IO.puts "sample_parse_and_generate"
    IO.inspect Plot.parse_and_generate("""
      {game {
          id
        }}
      """)
  end

  test "sample_parse_mutation" do
    IO.puts "sample_parse_mutation"
    IO.inspect Plot.parse("""
      mutation Mutation($input:CheckHidingSpotForTreasureInput!) {
        checkHidingSpotForTreasure(input:$input) {
          clientMutationId
        }
      }
      """)
  end

  test "sample_parse_mutation2" do
    IO.puts "sample_parse_mutation2"
    IO.inspect Plot.parse("""
      mutation Mutation {
        checkHidingSpotForTreasure(input: {id: "SGlkaW5nU3BvdDoz", clientMutationId: "0"} ) {
          clientMutationId
        }
      }
      """)
  end

  test "sample_parse_mutation3" do
    IO.puts "sample_parse_mutation2"
    IO.inspect Plot.parse("""
      mutation Mutation {
        checkHidingSpotForTreasure(input: "test" ) {
          clientMutationId
        }
      }
      """)
  end

  test "sample_schema" do
    IO.puts "sample_schema"
    IO.inspect Plot.Schema.parse("""
        input CheckHidingSpotForTreasureInput {
          id: ID!
          clientMutationId: String!
        }
        type CheckHidingSpotForTreasurePayload {
          hidingSpot: HidingSpot
          game: Game
          clientMutationId: String!
        }
        type Game implements Node {
          id: ID!
          hidingSpots(before: String, after: String, first: Int, last: Int): HidingSpotConnection
          turnsRemaining: Int
        }
        type HidingSpot implements Node {
          id: ID!
          hasBeenChecked: Boolean
          hasTreasure: Boolean
        }
        type HidingSpotConnection {
          pageInfo: PageInfo!
          edges: [HidingSpotEdge]
        }
        type HidingSpotEdge {
          node: HidingSpot
          cursor: String!
        }
        type Mutation {
          checkHidingSpotForTreasure(input: CheckHidingSpotForTreasureInput!): CheckHidingSpotForTreasurePayload
        }
        interface Node {
          id: ID!
        }
        type PageInfo {
          hasNextPage: Boolean!
          hasPreviousPage: Boolean!
          startCursor: String
          endCursor: String
        }
        type Query {
          node(id: ID!): Node
          game: Game
        }
      """)
  end
end