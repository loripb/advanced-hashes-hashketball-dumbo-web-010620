def game_hash
  data ={
    home: {
      team_name: "Brooklyn Nets",
      colors: ['Black', 'White'],
      players: [{
        player_name: "Alan Anderson",
        number: 0,
        shoe: 16,
        points: 22,
        rebounds: 12,
        assists: 12,
        steals: 3,
        blocks: 1,
        slam_dunks: 1
      },
      {
        player_name: "Reggie Evans",
        number: 30,
        shoe: 14,
        points: 12,
        rebounds: 12,
        assists: 12,
        steals: 12,
        blocks: 12,
        slam_dunks: 7
      },
      {
        player_name: "Brook Lopez",
        number: 11,
        shoe: 17,
        points: 17,
        rebounds: 19,
        assists: 10,
        steals: 3,
        blocks: 1,
        slam_dunks: 15
      },
      {
        player_name: "Mason Plumlee",
        number: 1,
        shoe: 19,
        points: 26,
        rebounds: 11,
        assists: 6,
        steals: 3,
        blocks: 8,
        slam_dunks: 5
      },
      {
        player_name: "Jason Terry",
        number: 31,
        shoe: 15,
        points: 19,
        rebounds: 2,
        assists: 2,
        steals: 4,
        blocks: 11,
        slam_dunks: 1
      }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [{
        player_name: "Jeff Adrien",
        number: 4,
        shoe: 18,
        points: 10,
        rebounds: 1,
        assists: 1,
        steals: 2,
        blocks: 7,
        slam_dunks: 2
      },
      {
        player_name: "Bismack Biyombo",
        number: 0,
        shoe: 16,
        points: 12,
        rebounds: 4,
        assists: 7,
        steals: 22,
        blocks: 15,
        slam_dunks: 10
      },
      {
        player_name: "DeSagna Diop",
        number: 2,
        shoe: 14,
        points: 24,
        rebounds: 12,
        assists: 12,
        steals: 4,
        blocks: 5,
        slam_dunks: 5
      },
      {
        player_name: "Ben Gordon",
        number: 8,
        shoe: 15,
        points: 33,
        rebounds: 3,
        assists: 2,
        steals: 1,
        blocks: 1,
        slam_dunks: 0
      },
      {
        player_name: "Kemba Walker",
        number: 33,
        shoe: 15,
        points: 6,
        rebounds: 12,
        assists: 12,
        steals: 7,
        blocks: 5,
        slam_dunks: 12
      }]
    }
  }
end

def get_all_players
  game_hash[:home][:players] + game_hash[:away][:players]
end

def num_points_scored(player_name)
  result = 0
  players = get_all_players

  players.each do |player|
     if player[:player_name] == player_name
       result = player[:points]
     end
  end
  result
end

def shoe_size(player_name)
  result = 0
  players = get_all_players

  players.each do |player|
     if player[:player_name] == player_name
       result = player[:shoe]
     end
  end

  result
end

def team_colors(team_name)
  result = []
  home = game_hash[:home]
  away = game_hash[:away]

  if team_name == home[:team_name]
    result = home[:colors]
  else
    result = away[:colors]
  end
  result
end

def team_names
  names = [game_hash[:home][:team_name], game_hash[:away][:team_name]]
  names
end

def player_numbers(team_name)
  result = []
  home = game_hash[:home]
  away = game_hash[:away]

  if team_name == home[:team_name]
    home[:players].each { |player| result << player[:number]}
  else
    away[:players].each { |player| result << player[:number]}
  end
  result
end

def player_stats(player_name)
  result = {}
  players = get_all_players

  players.each do |player|
     if player[:player_name] == player_name
       result = create_stat_hash(player)
     end
  end

  result
end

def create_stat_hash(player_info)
  result = {
    assists:    player_info[:assists],
    blocks:     player_info[:blocks],
    number:     player_info[:number],
    points:     player_info[:points],
    rebounds:   player_info[:rebounds],
    shoe:       player_info[:shoe],
    slam_dunks: player_info[:slam_dunks],
    steals:     player_info[:steals]
  }
end

def big_shoe_rebounds
  players = get_all_players
  rebounds = 0
  
  players.reduce(nil) do |biggest_shoe, player_info|
    biggest_shoe = player_info[:shoe] if !biggest_shoe


    if player_info[:shoe] > biggest_shoe
      biggest_shoe = player_info[:shoe]
      rebounds = player_info[:rebounds]
    end
    biggest_shoe
  end

  rebounds
end

def most_points_scored
  players = game_hash[:home][:players] + game_hash[:away][:players]
  player_name = ''

  players.reduce(nil) do |points, player_info|
    points = player_info[:points] if !points

    if player_info[:points] > points
      points = player_info[:points]
      player_name = player_info[:player_name]
    end
    points
  end
  player_name
end

def winning_team
  home_points = calculate_points(game_hash[:home][:players])
  away_points = calculate_points(game_hash[:away][:players])

  if home_points > away_points
    game_hash[:home][:team_name]
  else
    game_hash[:away][:team_name]
  end
end

def calculate_points(team)
  team.reduce(nil) do |points, player_info|
    points = 0 if !points

    points += player_info[:points]
    points
  end
end

def player_with_longest_name
  players = game_hash[:home][:players] + game_hash[:away][:players]
  longest_name = ''

  players.reduce(nil) do |player_name, player_info|
    player_name = '' if !player_name

    if player_info[:player_name].length > player_name.length
      player_name = player_info[:player_name]
      longest_name = player_info[:player_name]
    end
    player_name
  end
  longest_name
end

def long_name_steals_a_ton?
  player_in_question = player_with_longest_name
  players = game_hash[:home][:players] + game_hash[:away][:players]
  person_with_most_steals = ''

  players.reduce(nil) do |steals, player_info|
    steals = player_info[:steals] if !steals

    if player_info[:steals] > steals
      steals = player_info[:steals]
      person_with_most_steals = player_info[:player_name]
    end
    steals
  end

  if player_in_question == person_with_most_steals
    true
  else
    puts "You made a mistake somewhere"
  end
end
