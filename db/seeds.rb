# frozen_string_literal: true

["vocals", "guitar", "bass guitar", "keyboard", "drums"].each do |instrument| 
  Instrument.create(name: instrument)
end
