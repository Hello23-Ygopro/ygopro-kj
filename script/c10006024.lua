--Bonerattle Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TERROR_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to discard pile
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
end
--to discard pile
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	local p=(opt==1 and tp) or (opt==2 and 1-tp)
	Duel.KJSendDecktoptoDPile(p,2,REASON_EFFECT)
end
--[[
	References
	* Mooyan Curry
	https://github.com/Fluorohydride/ygopro-scripts/blob/master/c58074572.lua
]]
