local lfs = require"lfs"

--获取文件名  
function getFileName(str)  
    local idx = str:match(".+()%.%w+$")  
    if(idx) then  
        return str:sub(1, idx-1)  
    else  
        return str  
    end  
end

--获取文件扩展名
function getExtension(str)  
    return str:match(".+%.(%w+)$")  
end

function headerConverter (path, newpath, chromatixtype)
	lfs.mkdir(newpath)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'\\'..file
			local f1 = newpath..'\\'..file
            local attr = lfs.attributes (f)
            --assert (type(attr) == "table")
			--print(attr.mode, f)
            if attr.mode == "directory" then
				if file == "isp" then
					chromatixtype = "default "
				end
				if file == "cpp" then
					chromatixtype = "cpp "
				end
				if file == "common" then
					chromatixtype = "common "
				end
				if file == "3A" or file == "3a" then
					chromatixtype = "3a "
				end
				if file == "postproc" or file == "swpostproc" then
					chromatixtype = "swpostproc "
				end
				headerConverter(f, f1, chromatixtype)
			end
			
			if attr.mode == "file" then
				--print(getExtension(f))
				if (getExtension(f) == "h") then
					print("HeaderConverter.exe -i 0x308 -o 0x310 -t "..chromatixtype..f.." "..f1)
					os.execute("HeaderConverter.exe -i 0x308 -o 0x310 -t "..chromatixtype..f.." "..f1)
				else
					print("copy "..f.." "..f1)
					os.execute("copy "..f.." "..f1)
				end
				--os.execute("copy "..f.." "..f1)
				--print("copy "..f.." "..f1)
			end
        end
    end
end

headerConverter("chromatix_imx230_idol4pro_cn", "chromatix_imx230_idol4pro_cn_310", "default ")

os.execute("pause")
