
local richText = {}
local innerTb = {}
richText.innerTb = innerTb

local function drawText(text, font, size, color, x, y)
  local nSize = 20
  if type(size) ~= "number" then
    nSize = tonumber(size)
  end
  return display.newTTFLabel({text = text, font=font, size=nSize, color=cc.c3b(255,255,0), x=x, y=y, valign=cc.VERTICAL_TEXT_ALIGNMENT_CENTER})
end

local function getPairs(str, tb)
  local node = display.newNode()
  for k, attr, v in string.gmatch(str,"<(%w+)%s?(.*)>(.-)</%1>") do
      print("name:"..k)
      print("text:"..v)
    local tb = {}
    innerTb[k] = tb
    tb.value = v
    
    local tbAtrr = {}
    tb.attr = tbAtrr 
    
    if attr ~= nil then
      for ak, av in string.gmatch(attr,"(%w+)=(%S*)") do
        tbAtrr[ak] = av or nil
        print(ak.."："..tbAtrr[ak])  
      end
    end
    
    if k=="font" then
      local lab = drawText(v, tbAtrr.type, tbAtrr.size, tbAtrr.color, 200, 300)
      node:add(lab)
    end
    
    print('----------------\n')
  end
  
  return node
end

richText.parseXML = function(str)
  local ret = nil
  print("inputString: "..str.."TYPE:"..type(str).."\n")
  if type(str) == "string" then
    ret = getPairs(str, innerTb)
  end
  return ret
end

return richText