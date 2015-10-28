package com.smarttrip.manageweb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smarttrip.domain.Schedule;
import com.smarttrip.manageweb.common.Result;
import com.smarttrip.service.IScheduleService;
import com.smarttrip.util.UUIDUtils;

/**
 * @author gaoweibupt@gmail.com
 * @version Date：2015年10月28日下午7:56:39
 */

@Controller
@RequestMapping("/schedule")
public class scheduleController {

	@Autowired
	private IScheduleService scheduleService;
	
	/**
	 * 新建一条行程
	 * */
	@RequestMapping("/newSchedule")
	@ResponseBody
	public Result newSchedul(Model model, Schedule schedule){
		Result result = new Result();
		schedule.setScheduleId(UUIDUtils.getUUID());
		if (scheduleService.insert(schedule) == 1){
			return result;
		}
		else{
			result.setStatus("failed");
			return result;
		}
	}
	
}
