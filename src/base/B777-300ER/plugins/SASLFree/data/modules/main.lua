size={2048,2048}

panelWidth3d = 2048  --I don't know why, but without those lines you cannot get the coords to work right
panelHeight3d = 2048
--  Avionics.lua  8-10-2013  Steve Wilson
--  Modify as needed to support your other SASL scripts in the Custom Avionics folder.  Safe landings!

components={

_Main_Data {};
Draw {
	position={0,0,400,640}
};
_Main_Sound {};

Panel_EICAS {};
Panel_MCP {};
Panel_PFD {};
Panel_Gear {};

System_Fuel {};
System_Engine {};
System_Radio {};
System_Bleed {};
System_FlightMode {};

}
