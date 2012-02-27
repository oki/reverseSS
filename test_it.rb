#!/usr/bin/env ruby

require 'rubygems'
require "bundler/setup"
require 'bindata'
require 'pp'

# io = IO.read('packet.dump')
io = IO.read('with-gpx.dump')

class AsString < BinData::Primitive
    endian :big
    uint16 :len, :value => lambda { data.length }
    string :data, :read_length => :len

    def get
        self.data
    end

    def set(v)
        self.data = v
    end
end

class Workout < BinData::Record
    endian :big

    uint32 :versionNumber
    uint32 :headerSize
    uint32 :applicationId
    uint32 :machineId
    uint32 :features 

    uint16 :featureFlags
    uint16 :sharingFlags
    uint32 :workoutId

    as_string :description
    as_string :workoutkey

    uint32 :userid 
    uint32 :routeId 
    uint32 :activityId

    as_string :username
    as_string :workoutName

    uint32 :timeOffset
    double :startTime
    double :stopTime

    uint32 :totalTime
    uint32 :totalDistance
    uint32 :weight

    uint32 :energyConsumed

    bit32 :measurementUnit

    as_string :mcc
    as_string :mnc
end

w = Workout.read(io)

if w.featureFlags & 1 << 11
    puts "isManuallyAdded"
end

w.field_names.each do |field_name|
    puts "#{field_name}: #{w.send(field_name)}"
end
