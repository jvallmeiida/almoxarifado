class MaterialLog < ApplicationRecord
  belongs_to :material
  belongs_to :user

  enum status: [:entrance, :exit]

  def translate_status
    # ideal é usar o arquivo pt-br para traduzir enum no rails
    return 'entrada' if entrance?
    return 'saída' if exit?
  end
end