# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  @candidates.select { |name| name[:id] == id }
end

def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

# More methods will go below

def github?(candidate)
  candidate[:github_points] >= 100
end

def languages?(candidate)
  candidate[:languages].include?('Ruby' || 'Python')
end

def applied?(candidate)
  candidate[:date_applied] >= 15.days.ago.to_date
end

def age?(candidate)
  candidate[:age] > 17
end

def qualified_candidates
  @candidates.select do |test|
    experienced?(test) && github?(test) && languages?(test) && applied?(test) && age?(test)
  end
end

def ordered_by_qualifications(candidates)
  listing = candidates.sort_by { |x| x[:years_of_experience]}.reverse
  listing.sort do |a, b|
    comp = (a[:github_points] <=> b[:github_points])
    comp.zero? ? a[:github_points] <=> b[:github_points] : comp
  end
  listing
end

def enquiry_repl
  i = 0
  while i < 1
    print "Please input a command"
    input = gets.chomp
    if input.match(/find\s\d/)
      puts find(input.match(/\d/).to_s.to_i)
    elsif input == "all"
      puts ordered_by_qualifications(@candidates)
    elsif input == "qualified"
      puts ordered_by_qualifications(qualified_candidates)
    elsif input == "quit"
      i = 1
    else
      puts "Incorrect input"
    end
  end
end

