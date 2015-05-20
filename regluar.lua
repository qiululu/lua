
local richText = {}
local innerTb = {}
richText.innerTb = innerTb

local function drawText(text, font, size, color, x, y)
  local nSize = 20
  if size ~= nil then
    if type(size) ~= "number" then
      nSize = tonumber(size)
    else
      nSize = size
    end
  end
  return display.newTTFLabel({text = text, font=font, size=nSize, color=cc.c3b(255,255,0), x=x, y=y, valign=cc.VERTICAL_TEXT_ALIGNMENT_CENTER})
end

local function getPairs(str, tb)
  local node = display.newNode()
  --处理简写的标签
  local strFull = string.sub(str, '<(%w+)(%s?.*)/>', '<%1%2></%1>')

  --析取标签名，参数列表，文本值
  for k, attr, v in string.gmatch(strFull,'<(%w+)%s?(.*)>(.-)</%1>') do
      print("name:"..k..'\n')
      print("text:"..v..'\n')
    local tb = {}
    innerTb[k] = tb
    
    local tbAtrr = {}
    tb.value = v
    tb.attr = tbAtrr 
    
    --创建标签参数列表
    if attr ~= nil then
      for ak, av in string.gmatch(attr,'(%w+)=(%S*)') do
        tbAtrr[ak] = av or nil

        print(ak.."："..tbAtrr[ak]..'\n')  
      end
    end
    
    if k == 'font' then
      local lab = drawText(v, tbAtrr.type, tbAtrr.size, tbAtrr.color, 200, 300)
      node:add(lab)
    elseif k == 'br' then
      --处理换行
    elseif k == 'img' then
      if tbAtrr.src then
        -- 根据默认或手动添加的路径加载图片
      end
      if tbAtrr.width or tbAtrr.height then
        -- 指定控件大小，适配尺寸
      end
    elseif k == 'a' then
      
    end
    
    print('----------------\n')
  end
  
  return node
end

richText.parseXML = function(str)
  local ret = nil
  if type(str) == "string" then
    ret = getPairs(str, innerTb)
  end
  return ret
end

return richText