module PackagesHelper
  def package_index_columns
    Package.columns.map(&:name) - %w(
      created_at updated_at description authors maintainers status id
    )
  end
end
