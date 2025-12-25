class DAG
  attr_accessor :edges

  def paths_between(origin, destination)
    self.graph = {}
    self.indegrees = {}
    self.ways = { origin => 1 }
    build_indegrees
    build_graph
    build_ways
    ways[destination]
  end

  def paths_following(verticies)
    self.graph = {}
    self.indegrees = {}
    build_indegrees
    build_graph
    p graph
  end

  private

  attr_accessor :graph, :indegrees, :ways

  def build_graph
    edges.each do |edge|
      # Initialize the source and destination verticies if needed
      graph[edge[0]] = [] unless graph[edge[0]]
      graph[edge[1]] = [] unless graph[edge[1]]
      # Add destination vertex to source vertex's list
      graph[edge[0]].push edge[1]
    end
  end

  def build_indegrees
    edges.each do |edge|
      # The source vertex needs to get added if it's not already in the indegrees hash
      indegrees[edge[0]] = 0 unless indegrees.key? edge[0]
      # The destination vertex either needs to be intialized with 1 indegree, or have
      # its indegrees incremented
      if indegrees.key? edge[1]
        indegrees[edge[1]] += 1
      else
        indegrees[edge[1]] = 1
      end
    end
  end

  def build_ways
    topologically_sorted_verticies.each do |vertex|
      ways[vertex] = 0 unless ways.key? vertex
      destinations = graph[vertex]
      destinations.each do |destination|
        if ways.key? destination
          ways[destination] += ways[vertex]
        else
          ways[destination] = ways[vertex]
        end
      end
    end
  end

  def topologically_sorted_verticies
    sorted = []
    queue = verticies_with_no_indegrees
    indegree_counts = indegrees.clone
    until queue.empty?
      vertex = queue.shift
      sorted.push vertex
      destinations = graph[vertex]
      destinations.each do |destination|
        indegree_counts[destination] -= 1
        queue.push destination if indegree_counts[destination].zero?
      end
    end
    sorted
  end

  def verticies_with_no_indegrees
    # Find verticies with 0 indegrees
    indegrees.filter { |_, v| v.zero? }.keys
  end
end
