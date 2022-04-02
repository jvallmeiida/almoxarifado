module Services
  module Material
    class MaterialLogService
      def initialize(material, quantity_entrance, quantity_exit)
        @material = material
        @quantity_entrance = quantity_entrance
        @quantity_exit = quantity_exit
      end

      def material_exit
        material_log = ::MaterialLog.new(user: @material.user, material: @material, quantity: @quantity_exit.to_i, status: 'exit')
        material_log.save
      end

      def material_entrance
        material_log = ::MaterialLog.new(user: @material.user, material: @material, quantity: @quantity_entrance.to_i, status: 'entrance')
        material_log.save
      end
    end
  end
end