package com.kh.curaeasy.display.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DisplayController {

    @RequestMapping("onDisplay.do")
    public String ongoingDisplay() {
        return "display/onDisplayView";
    }

    @RequestMapping("offDisplay.do")
    public String closedDisplay() {
        return "display/closedDisplayView";
    }

    @RequestMapping("introduce.do")
    public String artistIntroduction() {
        return "display/artistIntroduceView";
    }
}
