module TreeTraversable
  extend ActiveSupport::Concern

  included do
    scope :root_nodes, -> { where(parent_id: nil) }

    def root?
      parent_id.nil?
    end
  end

  class_methods do
    def find_roots_with_children
      find_by_sql <<-SQL
        WITH RECURSIVE children(#{column_names.join(',')}) AS (
          #{root_nodes.to_sql}
          UNION
          SELECT t2.*
          FROM #{table_name} t2, children t1 WHERE t2.parent_id = t1.id
        )
        SELECT * FROM children;
      SQL
    end
  end
end
