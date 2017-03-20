import re

#dataPoints = ["Performing test","Operations performed:","Total transferred","Requests/sec executed","total time:","approx.  95 percentile:","transactions:","read:","write:","other:","total:","read/write requests:"]
dataPoint = "Total transferred"

baselineHD = "Baseline/RW-direct-4k"
baselineHD2 = "Baseline/RW-direct-1m"
baselineHD3 = "Baseline/RR-direct-4k"
baselineHD4 = "Baseline/RR-direct-1m"
baselineSQL = "Baseline/SQL"
baselineCPU = "Baseline/CPU"

dockerHD = "Docker/data-1container/RW-direct-4k"
dockerHD2 = "Docker/data-1container/RW-direct-1m"
dockerHD3 = "Docker/data-1container/RR-direct-4k"
dockerHD4 = "Docker/data-1container/RR-direct-1m"
dockerSQL = "Docker/data-1container/SQL"
dockerCPU = "Docker/data-1container/CPU"
dockerCompete = "Docker/data-compete/RW-4k-1"
dockerCompete2 = "Docker/data-compete/RW-4k-2"
dockerCompete3 = "Docker/data-compete/RR-4k-1"
dockerCompete4 = "Docker/data-compete/RR-4k-2"
dockerIPC = "Docker/data-ipc/SQL"

vmHD = "VM/data-vm/RW-direct-4k"
vmHD2 = "VM/data-vm/RW-direct-1m"
vmHD3 = "VM/data-vm/RR-direct-4k"
vmHD4 = "VM/data-vm/RR-direct-1m"
vmSQL = "VM/data-vm/SQL"
vmCPU = "VM/data-vm/CPU"
vmCompete = "VM/data-compete/RW-4k-1"
vmCompete2 = "VM/data-compete/RW-4k-2"
vmCompete3 = "VM/data-compete/RR-4k-1"
vmCompete4 = "VM/data-compete/RR-4k-2"
vmIPC = "VM/data-ipc/SQL"



def regexValues(input):
	temp = re.findall("\d+[\.]?\d*", input)
	if ("Total transferred" in input):
		if (re.findall("b|Mb|Gb", input)[0] == "Mb"):
			temp[0] = (float(temp[0])/1000)
		if (re.findall("b|Mb|Gb", input)[1] == "Mb"):
			temp[1] = (float(temp[1])/1000)
		if (re.findall("b|Mb|Gb", input)[2] == "Mb"):
			temp[2] = (float(temp[2])/1000)
		if (re.findall("b|Mb|Gb", input)[3] == "Gb"):
			temp[3] = (float(temp[3])*1000)
	return temp

def readLogFile(inputFileLocation):
	allData = []
	inputFile = open(inputFileLocation)
	for line in inputFile:
		if dataPoint in line:
			allData.append(regexValues(line.strip()))
	inputFile.close()
	return allData

def calculateAverages(allData):
	assert (len(allData) % 4 == 0), "wrone length of data"
	averages = []
	i = 0
	while (i < len(allData)):
		newList = []
		for each in range(len(allData[0])):
			newList.append(0)
			for cycle in range(i, i+4):
				#assert (len(allData[i]) == 4), allData[i]
				newList[each] = newList[each] + float(allData[cycle][each])
			newList[each] = newList[each] / 4
		averages.append(newList)
		i = i+4
	return averages

def createOutputFile(filename, data, headers):
	output = open(filename, "w")
	for each in headers:
		output.write(each)
		output.write("\t")
	for row in data:
		output.write("\n")
		for item in row:
			output.write(str(item))
			output.write("\t")
	output.close()
	print "Done"

def run(fileName, outputFile, headers):
	data = readLogFile(fileName)
	averages = calculateAverages(data)
	createOutputFile(outputFile,averages, headers)

hdHeaders = ["Read","Written","Total_transferred","Mb/second"]

run(baselineHD,"Data/base-RW-direct-4k.tsv",hdHeaders)
run(baselineHD2,"Data/base-RW-direct-1m.tsv",hdHeaders)
run(baselineHD3,"Data/base-RR-direct-4k.tsv",hdHeaders)
run(baselineHD4,"Data/base-RR-direct-1m.tsv",hdHeaders)
run(dockerHD,"Data/docker-RW-direct-4k.tsv",hdHeaders)
run(dockerHD2,"Data/docker-RW-direct-1m.tsv",hdHeaders)
run(dockerHD3,"Data/docker-RR-direct-4k.tsv",hdHeaders)
run(dockerHD4,"Data/docker-RR-direct-1m.tsv",hdHeaders)
run(vmHD,"Data/vm-RW-direct-4k.tsv",hdHeaders)
run(vmHD2,"Data/vm-RW-direct-1m.tsv",hdHeaders)
run(vmHD3,"Data/vm-RR-direct-4k.tsv",hdHeaders)
run(vmHD4,"Data/vm-RR-direct-1m.tsv",hdHeaders)
run(dockerCompete,"Data/docker-RW-compete-1.tsv",hdHeaders)
run(dockerCompete2,"Data/docker-RW-compete-2.tsv",hdHeaders)
run(dockerCompete3,"Data/docker-RR-compete-1.tsv",hdHeaders)
run(dockerCompete4,"Data/docker-RR-compete-2.tsv",hdHeaders)
run(vmCompete,"Data/vm-RW-compete-1.tsv",hdHeaders)
run(vmCompete2,"Data/vm-RW-compete-2.tsv",hdHeaders)
run(vmCompete3,"Data/vm-RR-compete-1.tsv",hdHeaders)
run(vmCompete4,"Data/vm-RR-compete-2.tsv",hdHeaders)

dataPoint = "total:"
run(baselineSQL,"Data/base-SQL-total.tsv",["Queries_Performed_Total"])
run(dockerSQL,"Data/docker-SQL-total.tsv",["Queries_Performed_Total"])
run(vmSQL,"Data/vm-SQL-total.tsv",["Queries_Performed_Total"])
run(dockerIPC,"Data/docker-IPC-SQL-total.tsv",["Queries_Performed_Total"])
run(vmIPC,"Data/vm-IPC-SQL-total.tsv",["Queries_Performed_Total"])

dataPoint = "approx.  95 percentile:"
run(baselineSQL,"Data/base-SQL-95.tsv",["Percentile","95_percent_latency"])
run(dockerSQL,"Data/docker-SQL-95.tsv",["Percentile","95_percent_latency"])
run(vmSQL,"Data/vm-SQL-95.tsv",["Percentile","95_percent_latency"])
run(dockerIPC,"Data/docker-IPC-SQL-95.tsv",["Percentile","95_percent_latency"])
run(vmIPC,"Data/vm-IPC-SQL-95.tsv",["Percentile","95_percent_latency"])

dataPoint = "total time:"
run(baselineCPU,"Data/base-CPU-time.tsv",["Time_Taken"])
run(dockerCPU,"Data/docker-CPU-time.tsv",["Time_Taken"])
run(vmCPU,"Data/vm-CPU-time.tsv",["Time_Taken"])

print "All files processed. Exiting."