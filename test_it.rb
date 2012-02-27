#!/usr/bin/env ruby

require 'rubygems'
require "bundler/setup"
require 'bindata'
require 'pp'

io = IO.read('packet.dump')

class Workout < BinData::Record
    #endian :little
    endian :big

    uint32 :versionNumber
    uint32 :headerSize
    uint32 :applicationId
    uint32 :machineId
    uint32 :features 

    uint16 :featureFlags
    uint16 :sharingFlags
    uint32 :workoutId
end

w = Workout.read(io)

puts "versionNumber: #{w.versionNumber}"
puts "headerSize: #{w.headerSize}"
puts "applicationId: #{w.applicationId}"
puts "machineId: #{w.machineId}"
puts "features: #{w.features}"
puts "featureFlags: #{w.featureFlags}"
puts "sharingFlags: #{w.sharingFlags}"
puts "workoutId: #{w.workoutId}"
