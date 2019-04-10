-- reverse_thrust.lua --
-- Steve Wilson    8-10-2013

--  0.1	Initial Release

volume_ratio = 0.7   		--  set this value to taste or to match your X-Plane engines volume setting.
number_of_engines = 8  	-- this can stay at 8, but for efficiency (frames count!) adjust to the correct value 
					-- for your aircraft

					
-- **************** NOTE ****************
-- This script uses the stock X-Plane afterburner sound with a bit of a tweak.  If using a different sound, then modify the sound file name and path as well as 
-- other sound functions accordingly.
-- **************** NOTE ****************
					
-- first we must find the sound since we don't know for sure what directory the aircraft folder is stored in
-- normally it's something like X-Plane/aircraft/aircraft_name 
-- or X-Plane/aircraft/aircraft_type/aircraft_name
-- but we don't know, so we have to hunt a bit...

-- we start searching buried two folders deeper than the X-Plane/aircraft folder, one folder deeper than normal

sound_file = "../../../../../sounds/engine/reverse_thrust_INN.wav"

if not isFileExists(sound_file) then 
	
	sound_file = "../../../../sounds/engine/reverse_thrust_INN.wav"  -- normal location
	
	if not isFileExists(sound_file) then 
		
		sound_file = "../../../sounds/engine/reverse_thrust_INN.wav" -- aircraft folder located in aircraft directory
			
	end
end

-- if the user has their aircraft folder in a really arcane location, this ain't gonna produce any sound.  Sorry!

-- sound resources and array initialization

s_Reverse = {}  	-- sound sample
n1 = {}		-- engine n1 value read from dataref
rev = {}		-- reverser deployment ratio
rev_gain = {}  	-- loudness of reverser

for i = 1,8 do
	s_Reverse[i] = loadSample(sound_file)
	
	setSamplePitch(s_Reverse[i],500)  					-- lower the pitch of the afterburner sound.  Deeper rumble.
	setSampleEnv (s_Reverse[i], SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out
	setSampleGain(s_Reverse[i],0)					-- initalize at zero volume since we build the sound as the reverser deploys
	n1[i] = 0   									
	rev[i] = 0  									
	rev_gain[i] = 0 								
end

---- input datarefs   array values would be cleaner, but this is a limitation of SASL
defineProperty("x", createGlobalPropertyf("donut/m", 1.0))

defineProperty("n1val_1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]"))
defineProperty("n1val_2", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]"))
defineProperty("n1val_3", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]"))
defineProperty("n1val_4", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[3]"))
defineProperty("n1val_5", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[4]"))
defineProperty("n1val_6", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[5]"))
defineProperty("n1val_7", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[6]"))
defineProperty("n1val_8", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[7]"))

defineProperty("rev_val_1", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]"))
defineProperty("rev_val_2", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[1]"))
defineProperty("rev_val_3", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]"))
defineProperty("rev_val_4", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[3]"))
defineProperty("rev_val_5", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[4]"))
defineProperty("rev_val_6", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[5]"))
defineProperty("rev_val_7", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[6]"))
defineProperty("rev_val_8", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[7]"))


function update ()

-- read datarefs for this frame

    set(x, 7.0)

	n1[1] = get (n1val_1)
	n1[2] = get (n1val_2)
	n1[3] = get (n1val_3)
	n1[4] = get (n1val_4)
	n1[5] = get (n1val_5)
	n1[6] = get (n1val_6)
	n1[7] = get (n1val_7)
	n1[8] = get (n1val_8)	
	
	rev[1] = get (rev_val_1)
	rev[2] = get (rev_val_2)
	rev[3] = get (rev_val_3)
	rev[4] = get (rev_val_4)
	rev[5] = get (rev_val_5)
	rev[6] = get (rev_val_6)
	rev[7] = get (rev_val_7)
	rev[8] = get (rev_val_8)
	
	reverse()  -- make some noise

end -- function update

function reverse()

	for i = 1,number_of_engines do

		rev_gain[i] =  .01 * n1[i] * rev[i] * 1000 * volume_ratio  -- as the reverser deploys, N1 is increasing.  
											     -- both factors affect played volume as a ratio of max volume and 
											     -- the configured volume ratio
		
		--if isSamplePlaying(s_Reverse[i]) then			 -- if the sample is playing, set it to the current gain value
			setSampleGain(s_Reverse[i],rev_gain[i] )
		--end
		
		-- if rev_gain[i] > 0 then    --This is test code, good to enable if you don't hear anything.
		--	logInfo ("Should be playing sound here.")
		-- end
		
		if rev_gain[i] > 0 then					-- if the gain value is greater than zero, we should be playing sound.  correct as needed
				if not isSamplePlaying(s_Reverse[i]) then
					playSample(s_Reverse[i], 1)
				end
		end
		if rev_gain[i] == 0 then					-- once the reverser is completely retracted, it zeroes out the gain and we can stop
			stopSample (s_Reverse[i])			-- playing sound
		end
	end

end

--  That about does it.  See the readme if you have any questions.  Thanks to Dan Klaue and Dozer for their fine examples that helped 
--  me get this far.  Cheers!    - Steve Wilson, August 2013


	
