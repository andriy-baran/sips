class Manage::Products::UpdateHandler < ApplicationHandler
  define do
    params Manage::Products::CreateHandler::Params

    query do
      attr_accessor :product

      def variant
        product&.variant
      end

      validate do
        errors.add(:not_found, 'No variant') if variant.nil?
      end
    end

    command do
      def call(response)
        ::ApplicationRecord.transaction do
          product.update!(title: title)
          variant.update!(weight: weight, price: price)
        rescue => e
          response.errors.add(:unprocessable_entity, e.message)
          raise ActiveRecord::Rollback
        end
      end
    end
  end

  def on_success(flow)
    flow.call(flow)
  end
end
