class AddEvaluationToNoPathological < ActiveRecord::Migration
  def change
    add_column :no_pathological_antecedents, :evaluation, :string
    add_column :pathological_antecedents, :pathology, :integer
    remove_column :no_pathological_antecedents, :note
    remove_column :pathological_antecedents, :note
  end
end
