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

asound_file = moduleDirectory.."/configuration/widgetResources/eng_max.wav"
bsound_file = moduleDirectory.."/configuration/widgetResources/eng_mid.wav"
csound_file = moduleDirectory.."/configuration/widgetResources/eng_idle.wav"
nsound_file = moduleDirectory.."/configuration/widgetResources/eng_n2.wav"

-- if the user has their aircraft folder in a really arcane location, this ain't gonna produce any sound.  Sorry!

-- sound resources and array initialization

s_Reverse = {}  	-- sound sample
al = 0
bl = 0
cl = 0
ar = 0
br = 0
cr = 0
n1 = {}		-- engine n1 value read from dataref
n2 = {}		-- engine n1 value read from dataref
rev = {}		-- reverser deployment ratio
rev_gain = {}  	-- loudness of reverser

for i = 1,2 do
	al = loadSample(asound_file)
	bl = loadSample(bsound_file)
	cl = loadSample(csound_file)
	nl = loadSample(nsound_file)
	ar = loadSample(asound_file)
	br = loadSample(bsound_file)
	cr = loadSample(csound_file)
	nr = loadSample(nsound_file)
	
	--setSamplePitch(s_Reverse[i],500)  					-- lower the pitch of the afterburner sound.  Deeper rumble.
	setSampleEnv (al, SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out				-- initalize at zero volume since we build the sound as the reverser deploys
	setSampleEnv (bl, SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out
	setSampleEnv (cl, SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out
	setSampleEnv (nl, SOUND_EVERYWHERE)
	setSampleEnv (ar, SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out				-- initalize at zero volume since we build the sound as the reverser deploys
	setSampleEnv (br, SOUND_EVERYWHERE)		-- just like X-Plane, use the same sound inside and out
	setSampleEnv (cr, SOUND_EVERYWHERE)
	setSampleEnv (nr, SOUND_EVERYWHERE)
	n1[i] = 0   									
	rev[i] = 0  									
	rev_gain[i] = 0 								
end

---- input datarefs   array values would be cleaner, but this is a limitation of SASL
defineProperty("n1val_1", globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 1))
defineProperty("n1val_2", globalPropertyfae("sim/flightmodel/engine/ENGN_N1_", 2))

defineProperty("n2val_1", globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 1))
defineProperty("n2val_2", globalPropertyfae("sim/flightmodel/engine/ENGN_N2_", 2))



function update ()

-- read datarefs for this frame

	n1[1] = get (n1val_1)
	n1[2] = get (n1val_2)

	n2[1] = get (n2val_1)
	n2[2] = get (n2val_2)

	rev[1] = 1
	rev[2] = 1
	
	reverse()  -- make some noise

end -- function update

function reverse()

	for i = 1, 2 do

		rev_gain[i] =  .01 * n1[i] * rev[i] * 1000 * volume_ratio  -- as the reverser deploys, N1 is increasing.  
											     -- both factors affect played volume as a ratio of max volume and 
											     -- the configured volume ratio
		
		--if isSamplePlaying(s_Reverse[i]) then			 -- if the sample is playing, set it to the current gain value
			setSampleGain(bl,((math.deg(math.sin (((n1[1]-30)*0.0729) + 4.7175))*2)+111) * 20*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			setSampleGain(al,1200 - (((math.deg(math.sin (((n1[1] - 33) * 0.01 * 1)/(0.05 * 3.145))) + (3.145)) + 1) * 10 - 1100) + 200)
			setSampleGain(nl,(n2[1] - 50) * get(globalPropertyf("sim/operation/sound/engine_volume_ratio")) * 20)
			if n1[1] > 50 then
				setSampleGain(al,(2500 - ((math.deg(math.sin (((n1[1]-20)*0.0729) + 4.7175))*2)+111) * 20+1000)*0.1*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			else
				setSampleGain(al,0)
				--setSampleGain(al, (1 - math.deg(math.sin (((n1[1] - 21) * 0.01 * get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))/0.05) + (3.145 * 1.5))) * 100)
			end
			if n1[1] < 70 then
				setSampleGain(cl, (2500 - ((math.deg(math.sin (((n1[1]-20)*0.0629) + 4.7175))*2)+111) * 20+1000)*0.001*n1[1]*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			else
				setSampleGain(cl,0)
			end
			setSamplePitch(nl,n2[1] * 10-10)
			setSamplePitch(al,n1[1] * 4 + 600)
			setSamplePitch(bl,n1[1] * 15)

			setSampleGain(br,((math.deg(math.sin (((n1[2]-30)*0.0729) + 4.7175))*2)+111) * 20*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			setSampleGain(ar,1200 - (((math.deg(math.sin (((n1[2] - 33) * 0.01 * 1)/(0.05 * 3.145))) + (3.145)) + 1) * 10 - 1100) + 200)
			if n1[2] > 50 then
				setSampleGain(ar,(2500 - ((math.deg(math.sin (((n1[2]-20)*0.0729) + 4.7175))*2)+111) * 20+1000)*0.1*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			else
				setSampleGain(ar,0)
				--setSampleGain(ar, (1 - math.deg(math.sin (((n1[2] - 21) * 0.01 * get(globarPropertyf("sim/operation/sound/engine_volume_ratio")))/0.05) + (3.145 * 1.5))) * 100)
			end
			if n1[2] < 70 then
				setSampleGain(cr, (2500 - ((math.deg(math.sin (((n1[2]-20)*0.0629) + 4.7175))*2)+111) * 20+1000)*0.001*n1[2]*get(globalPropertyf("sim/operation/sound/engine_volume_ratio")))
			else
				setSampleGain(cr,0)
			end
			setSamplePitch(ar,n1[2] * 4 + 600)
			setSamplePitch(br,n1[2] * 15)
		--end
		
		-- if rev_gain[i] > 0 then    --This is test code, good to enable if you don't hear anything.
		--	logInfo ("Should be playing sound here.")
		-- end
		
		if rev_gain[i] > 0 then					-- if the gain value is greater than zero, we should be playing sound.  correct as needed
				if (get(globalPropertyf("sim/time/sim_speed")) > 0) and (get(globalPropertyi("sim/operation/sound/sound_on")) > 0) then
					if not isSamplePlaying(al) then
						playSample(al, 1)
					end
					if not isSamplePlaying(bl) then
						playSample(bl, 1)
					end
					if not isSamplePlaying(cl) then
						playSample(cl, 1)
					end
					if not isSamplePlaying(nl) then
						playSample(nl, 1)
					end
					if not isSamplePlaying(ar) then
						playSample(ar, 1)
					end
					if not isSamplePlaying(br) then
						playSample(br, 1)
					end
					if not isSamplePlaying(cr) then
						playSample(cr, 1)
					end
				end
		end
		if (get(globalPropertyf("sim/time/sim_speed")) == 0) then		 		-- once the reverser is completely retracted, it zeroes out the gain and we can stop
			stopSample (al)			-- playing sound
			stopSample (bl)
			stopSample (cl)
			stopSample (nl)
			stopSample (ar)			-- playing sound
			stopSample (br)
			stopSample (cr)
		end
		if rev_gain[i] == 0 then
		end
	end

end

--  That about does it.  See the readme if you have any questions.  Thanks to Dan Klaue and Dozer for their fine examples that helped 
--  me get this far.  Cheers!    - Steve Wilson, August 2013


	
