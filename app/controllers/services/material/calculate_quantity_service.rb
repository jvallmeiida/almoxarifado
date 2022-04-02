module Services
  module Material
    class CalculateQuantityService
      def initialize(material, quantity_entrance, quantity_exit)
        @material = material
        @quantity_entrance = quantity_entrance
        @quantity_exit = quantity_exit
      end

      def negative
        material = ::Material.find_by(name: @material.name)
        material.update(quantity: material.quantity - @quantity_exit.to_i)
      end

      def positive
        material = ::Material.find_by(name: @material.name)
        material.update(quantity: material.quantity + @quantity_entrance.to_i)
      end
    end
  end
end