class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :materials

  enum role: [:usuario, :suporte, :administrador]

  scope :active, -> {where(active: true)}
  scope :inactive, -> {where(active: false)}

  before_destroy :impossible_destroy_user

  def full_name
    return if first_name.blank? || last_name.blank?

    [first_name, last_name].compact.join(' ')
  end

  def become_admin
    if User.all.count == 1 && !administrador?
      update(role: 'administrador')
    end
  end

  def translate_status
    return 'Ativo' if active
    return 'Inativo' if inactive
  end


  def active_for_authentication?
    super && active
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  private

  def impossible_destroy_user
    errors.add :base, "Impossível destruir usuário"

    throw(:abort)
  end
end
