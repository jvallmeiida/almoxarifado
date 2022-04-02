# frozen_string_literal: true

class MaterialsController < ApplicationController
  before_action :load_material, only: [:update, :edit, :destroy]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.user = current_user
    @material.quantity = total

    if @material.save
      redirect_to materials_path, notice: "Entrada de material #{@material.name}, feita com sucesso."
    else
      render :new, alert: 'Ocorreu um erro. Tente novamente!'
    end
  end

  def edit; end

  def update
    if !business_hours_available? && quantity_exit.present?
      flash.now[:alert] = 'Fora do horário comercial para retirada de estoque!'
      return render :edit
    elsif @material.update(material_params)
      redirect_to materials_path, notice: "Material #{@material.name}, atualizado com sucesso."

      create_logs
      calculate_new_quantity
    else
      render :edit, alert: 'Ocorreu um erro ao atualizar material, verifique seu estoque!'
    end
  end

  def destroy
    if material_with_logs?
      return redirect_to materials_path, notice: 'O material já tem logs.'
    else
      @material.destroy
      redirect_to materials_path, notice: 'O material foi excluído com sucesso.'
    end
  end

  private

  def load_material
    @material = Material.find(params[:id])
  end

  def total
    return quantity_entrance if quantity_entrance.present?
    return quantity_exit if quantity_exit.present?
  end

  def create_logs
    if quantity_exit.present?
      Services::Material::MaterialLogService.new(@material, quantity_entrance, quantity_exit).material_exit
    end

    if quantity_entrance.present?
      Services::Material::MaterialLogService.new(@material, quantity_entrance, quantity_exit).material_entrance
    end
  end

  def calculate_new_quantity
    if quantity_exit.present?
      Services::Material::CalculateQuantityService.new(@material, quantity_entrance, quantity_exit).negative
    end

    if quantity_entrance.present?
      Services::Material::CalculateQuantityService.new(@material, quantity_entrance, quantity_exit).positive
    end
  end

  def quantity_entrance
    params[:material][:quantity_entrance]
  end

  def quantity_exit
    params[:material][:quantity_exit]
  end

  def material_with_logs?
    @material.material_log.present?
  end

  def business_hours_available?
    business_range_hour = 9..18

    Date.today.on_weekday? && business_range_hour.include?(DateTime.now.hour)
  end

  def material_params
    params.required(:material).permit(:name, :quantity_entrance, :quantity_exit, :user_id)
  end
end