rule build_glimpse2:
	output:
		"bin/GLIMPSE2_chunk",
		"bin/GLIMPSE2_phase",
		"bin/GLIMPSE2_ligate"
	conda:
		"envs/glimpse_build.yaml"
	shell:
		r"""
		mkdir -p resources bin
		if [ ! -d resources/GLIMPSE ]; then
			git clone --recursive https://github.com/odelaneau/GLIMPSE.git resources/GLIMPSE
		fi
		
		cd resources/GLIMPSE/chunk && make
		cd ../phase && make
		cd ../ligate && make

		cp resoursces/GLIMPSE/chunk/bin/GLIMPSE2_chunk {output[0]}
		cp resoursces/GLIMPSE/phase/bin/GLIMPSE2_phase {output[1]}
		cp resoursces/GLIMPSE/ligate/bin/GLIMPSE2_ligate {output[2]}

		chmod +x {output[0]} {output[1]} {output[2]}
		"""
