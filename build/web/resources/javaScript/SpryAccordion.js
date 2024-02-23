

(function() { // BeginSpryComponent

    if (typeof Spry == "undefined") window.Spry = {};        
    if (!Spry.Widget) Spry.Widget = {};

    Spry.Widget.Accordion = function(element, opts)
    {
        this.element = this.getElement(element);
        this.defaultPanel = 0;
        this.hoverClass = "AccordionPanelTabHover";
        this.openClass = "AccordionPanelOpen";
        this.closedClass = "AccordionPanelClosed";
        this.focusedClass = "AccordionFocused";
        this.enableAnimation = true;
        this.enableKeyboardNavigation = true;
        this.currentPanel = null;
        this.animator = null;
        this.hasFocus = null;

        this.previousPanelKeyCode = Spry.Widget.Accordion.KEY_UP;
        this.nextPanelKeyCode = Spry.Widget.Accordion.KEY_DOWN;

        this.useFixedPanelHeights = true;
        this.fixedPanelHeight = 0;

        Spry.Widget.Accordion.setOptions(this, opts, true);

        if (this.element)
            this.attachBehaviors();
    };

    Spry.Widget.Accordion.prototype.getElement = function(ele)
    {
        if (ele && typeof ele == "string")
            return document.getElementById(ele);
        return ele;
    };

    Spry.Widget.Accordion.prototype.addClassName = function(ele, className)
    {
        if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) != -1))
            return;
        ele.className += (ele.className ? " " : "") + className;
    };

    Spry.Widget.Accordion.prototype.removeClassName = function(ele, className)
    {
        if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) == -1))
            return;
        ele.className = ele.className.replace(new RegExp("\\s*\\b" + className + "\\b", "g"), "");
    };

    Spry.Widget.Accordion.setOptions = function(obj, optionsObj, ignoreUndefinedProps)
    {
        if (!optionsObj)
            return;
        for (var optionName in optionsObj)
        {
            if (ignoreUndefinedProps && optionsObj[optionName] == undefined)
                continue;
            obj[optionName] = optionsObj[optionName];
        }
    };

    Spry.Widget.Accordion.prototype.onPanelTabMouseOver = function(e, panel)
    {
        if (panel)
            this.addClassName(this.getPanelTab(panel), this.hoverClass);
        return false;
    };

    Spry.Widget.Accordion.prototype.onPanelTabMouseOut = function(e, panel)
    {
        if (panel)
            this.removeClassName(this.getPanelTab(panel), this.hoverClass);
        return false;
    };

    Spry.Widget.Accordion.prototype.openPanel = function(elementOrIndex)
    {
        var panelA = this.currentPanel;
        var panelB;

        if (typeof elementOrIndex == "number")
            panelB = this.getPanels()[elementOrIndex];
        else
            panelB = this.getElement(elementOrIndex);
	
        if (!panelB || panelA == panelB)	
            return null;

        var contentA = panelA ? this.getPanelContent(panelA) : null;
        var contentB = this.getPanelContent(panelB);

        if (!contentB)
            return null;

        if (this.useFixedPanelHeights && !this.fixedPanelHeight)
            this.fixedPanelHeight = (contentA.offsetHeight) ? contentA.offsetHeight : contentA.scrollHeight;

        if (this.enableAnimation)
        {
            if (this.animator)
                this.animator.stop();
            this.animator = new Spry.Widget.Accordion.PanelAnimator(this, panelB, {
                duration: this.duration, 
                fps: this.fps, 
                transition: this.transition
            });
            this.animator.start();
        }
        else
        {
            if(contentA)
            {
                contentA.style.display = "none";
                contentA.style.height = "0px";
            }
            contentB.style.display = "block";
            contentB.style.height = this.useFixedPanelHeights ? this.fixedPanelHeight + "px" : "auto";
        }

        if(panelA)
        {
            this.removeClassName(panelA, this.openClass);
            this.addClassName(panelA, this.closedClass);
        }

        this.removeClassName(panelB, this.closedClass);
        this.addClassName(panelB, this.openClass);

        this.currentPanel = panelB;

        return panelB;
    };

    Spry.Widget.Accordion.prototype.closePanel = function()
    {
        // The accordion can only ever have one panel open at any
        // give time, so this method only closes the current panel.
        // If the accordion is in fixed panel heights mode, this
        // method does nothing.

        if (!this.useFixedPanelHeights && this.currentPanel)
        {
            var panel = this.currentPanel;
            var content = this.getPanelContent(panel);
            if (content)
            {
                if (this.enableAnimation)
                {
                    if (this.animator)
                        this.animator.stop();
                    this.animator = new Spry.Widget.Accordion.PanelAnimator(this, null, {
                        duration: this.duration, 
                        fps: this.fps, 
                        transition: this.transition
                    });
                    this.animator.start();
                }
                else
                {
                    content.style.display = "none";
                    content.style.height = "0px";
                }
            }		
            this.removeClassName(panel, this.openClass);
            this.addClassName(panel, this.closedClass);
            this.currentPanel = null;
        }
    };

    Spry.Widget.Accordion.prototype.openNextPanel = function()
    {
        return this.openPanel(this.getCurrentPanelIndex() + 1);
    };

    Spry.Widget.Accordion.prototype.openPreviousPanel = function()
    {
        return this.openPanel(this.getCurrentPanelIndex() - 1);
    };

    Spry.Widget.Accordion.prototype.openFirstPanel = function()
    {
        return this.openPanel(0);
    };

    Spry.Widget.Accordion.prototype.openLastPanel = function()
    {
        var panels = this.getPanels();
        return this.openPanel(panels[panels.length - 1]);
    };

    Spry.Widget.Accordion.prototype.onPanelTabClick = function(e, panel)
    {
        if (panel != this.currentPanel)
            this.openPanel(panel);
        else
            this.closePanel();

        if (this.enableKeyboardNavigation)
            this.focus();

        if (e.preventDefault) e.preventDefault();
        else e.returnValue = false;
        if (e.stopPropagation) e.stopPropagation();
        else e.cancelBubble = true;

        return false;
    };

    Spry.Widget.Accordion.prototype.onFocus = function(e)
    {
        this.hasFocus = true;
        this.addClassName(this.element, this.focusedClass);
        return false;
    };

    Spry.Widget.Accordion.prototype.onBlur = function(e)
    {
        this.hasFocus = false;
        this.removeClassName(this.element, this.focusedClass);
        return false;
    };

    Spry.Widget.Accordion.KEY_UP = 38;
    Spry.Widget.Accordion.KEY_DOWN = 40;

    Spry.Widget.Accordion.prototype.onKeyDown = function(e)
    {
        var key = e.keyCode;
        if (!this.hasFocus || (key != this.previousPanelKeyCode && key != this.nextPanelKeyCode))
            return true;
	
        var panels = this.getPanels();
        if (!panels || panels.length < 1)
            return false;
        var currentPanel = this.currentPanel ? this.currentPanel : panels[0];
        var nextPanel = (key == this.nextPanelKeyCode) ? currentPanel.nextSibling : currentPanel.previousSibling;

        while (nextPanel)
        {
            if (nextPanel.nodeType == 1 /* Node.ELEMENT_NODE */)
                break;
            nextPanel = (key == this.nextPanelKeyCode) ? nextPanel.nextSibling : nextPanel.previousSibling;
        }

        if (nextPanel && currentPanel != nextPanel)
            this.openPanel(nextPanel);

        if (e.preventDefault) e.preventDefault();
        else e.returnValue = false;
        if (e.stopPropagation) e.stopPropagation();
        else e.cancelBubble = true;

        return false;
    };

    Spry.Widget.Accordion.prototype.attachPanelHandlers = function(panel)
    {
        if (!panel)
            return;

        var tab = this.getPanelTab(panel);

        if (tab)
        {
            var self = this;
            Spry.Widget.Accordion.addEventListener(tab, "click", function(e) {
                return self.onPanelTabClick(e, panel);
            }, false);
            Spry.Widget.Accordion.addEventListener(tab, "mouseover", function(e) {
                return self.onPanelTabMouseOver(e, panel);
            }, false);
            Spry.Widget.Accordion.addEventListener(tab, "mouseout", function(e) {
                return self.onPanelTabMouseOut(e, panel);
            }, false);
        }
    };

    Spry.Widget.Accordion.addEventListener = function(element, eventType, handler, capture)
    {
        try
        {
            if (element.addEventListener)
                element.addEventListener(eventType, handler, capture);
            else if (element.attachEvent)
                element.attachEvent("on" + eventType, handler);
        }
        catch (e) {}
    };

    Spry.Widget.Accordion.prototype.initPanel = function(panel, isDefault)
    {
        var content = this.getPanelContent(panel);
        if (isDefault)
        {
            this.currentPanel = panel;
            this.removeClassName(panel, this.closedClass);
            this.addClassName(panel, this.openClass);

            // Attempt to set up the height of the default panel. We don't want to
            // do any dynamic panel height calculations here because our accordion
            // or one of its parent containers may be display:none.

            if (content)
            {
                if (this.useFixedPanelHeights)
                {
                    // We are in fixed panel height mode and the user passed in
                    // a panel height for us to use.
	
                    if (this.fixedPanelHeight)
                        content.style.height = this.fixedPanelHeight + "px";
                }
                else
                {
                    // We are in variable panel height mode, but since we can't
                    // calculate the panel height here, we just set the height to
                    // auto so that it expands to show all of its content.
	
                    content.style.height = "auto";
                }
            }
        }
        else
        {
            this.removeClassName(panel, this.openClass);
            this.addClassName(panel, this.closedClass);

            if (content)
            {
                content.style.height = "0px";
                content.style.display = "none";
            }
        }
	
        this.attachPanelHandlers(panel);
    };

    Spry.Widget.Accordion.prototype.attachBehaviors = function()
    {
        var panels = this.getPanels();
        for (var i = 0; i < panels.length; i++)
            this.initPanel(panels[i], i == this.defaultPanel);

        // Advanced keyboard navigation requires the tabindex attribute
        // on the top-level element.

        this.enableKeyboardNavigation = (this.enableKeyboardNavigation && this.element.attributes.getNamedItem("tabindex"));
        if (this.enableKeyboardNavigation)
        {
            var self = this;
            Spry.Widget.Accordion.addEventListener(this.element, "focus", function(e) {
                return self.onFocus(e);
            }, false);
            Spry.Widget.Accordion.addEventListener(this.element, "blur", function(e) {
                return self.onBlur(e);
            }, false);
            Spry.Widget.Accordion.addEventListener(this.element, "keydown", function(e) {
                return self.onKeyDown(e);
            }, false);
        }
    };

    Spry.Widget.Accordion.prototype.getPanels = function()
    {
        return this.getElementChildren(this.element);
    };

    Spry.Widget.Accordion.prototype.getCurrentPanel = function()
    {
        return this.currentPanel;
    };

    Spry.Widget.Accordion.prototype.getPanelIndex = function(panel)
    {
        var panels = this.getPanels();
        for( var i = 0 ; i < panels.length; i++ )
        {
            if( panel == panels[i] )
                return i;
        }
        return -1;
    };

    Spry.Widget.Accordion.prototype.getCurrentPanelIndex = function()
    {
        return this.getPanelIndex(this.currentPanel);
    };

    Spry.Widget.Accordion.prototype.getPanelTab = function(panel)
    {
        if (!panel)
            return null;
        return this.getElementChildren(panel)[0];
    };

    Spry.Widget.Accordion.prototype.getPanelContent = function(panel)
    {
        if (!panel)
            return null;
        return this.getElementChildren(panel)[1];
    };

    Spry.Widget.Accordion.prototype.getElementChildren = function(element)
    {
        var children = [];
        var child = element.firstChild;
        while (child)
        {
            if (child.nodeType == 1 /* Node.ELEMENT_NODE */)
                children.push(child);
            child = child.nextSibling;
        }
        return children;
    };

    Spry.Widget.Accordion.prototype.focus = function()
    {
        if (this.element && this.element.focus)
            this.element.focus();
    };

    Spry.Widget.Accordion.prototype.blur = function()
    {
        if (this.element && this.element.blur)
            this.element.blur();
    };

    /////////////////////////////////////////////////////

    Spry.Widget.Accordion.PanelAnimator = function(accordion, panel, opts)
    {
        this.timer = null;
        this.interval = 0;

        this.fps = 60;
        this.duration = 500;
        this.startTime = 0;

        this.transition = Spry.Widget.Accordion.PanelAnimator.defaultTransition;

        this.onComplete = null;

        this.panel = panel;
        this.panelToOpen = accordion.getElement(panel);
        this.panelData = [];
        this.useFixedPanelHeights = accordion.useFixedPanelHeights;

        Spry.Widget.Accordion.setOptions(this, opts, true);

        this.interval = Math.floor(1000 / this.fps);

        // Set up the array of panels we want to animate.

        var panels = accordion.getPanels();
        for (var i = 0; i < panels.length; i++)
        {
            var p = panels[i];
            var c = accordion.getPanelContent(p);
            if (c)
            {
                var h = c.offsetHeight;
                if (h == undefined)
                    h = 0;

                if (p == panel && h == 0)
                    c.style.display = "block";

                if (p == panel || h > 0)
                {
                    var obj = new Object;
                    obj.panel = p;
                    obj.content = c;
                    obj.fromHeight = h;
                    obj.toHeight = (p == panel) ? (accordion.useFixedPanelHeights ? accordion.fixedPanelHeight : c.scrollHeight) : 0;
                    obj.distance = obj.toHeight - obj.fromHeight;
                    obj.overflow = c.style.overflow;
                    this.panelData.push(obj);

                    c.style.overflow = "hidden";
                    c.style.height = h + "px";
                }
            }
        }
    };

    Spry.Widget.Accordion.PanelAnimator.defaultTransition = function(time, begin, finish, duration) {
        time /= duration;
        return begin + ((2 - time) * time * finish);
    };

    Spry.Widget.Accordion.PanelAnimator.prototype.start = function()
    {
        var self = this;
        this.startTime = (new Date).getTime();
        this.timer = setTimeout(function() {
            self.stepAnimation();
        }, this.interval);
    };

    Spry.Widget.Accordion.PanelAnimator.prototype.stop = function()
    {
        if (this.timer)
        {
            clearTimeout(this.timer);

            // If we're killing the timer, restore the overflow
            // properties on the panels we were animating!

            for (i = 0; i < this.panelData.length; i++)
            {
                obj = this.panelData[i];
                obj.content.style.overflow = obj.overflow;
            }
        }

        this.timer = null;
    };

    Spry.Widget.Accordion.PanelAnimator.prototype.stepAnimation = function()
    {
        var curTime = (new Date).getTime();
        var elapsedTime = curTime - this.startTime;

        var i, obj;

        if (elapsedTime >= this.duration)
        {
            for (i = 0; i < this.panelData.length; i++)
            {
                obj = this.panelData[i];
                if (obj.panel != this.panel)
                {
                    obj.content.style.display = "none";
                    obj.content.style.height = "0px";
                }
                obj.content.style.overflow = obj.overflow;
                obj.content.style.height = (this.useFixedPanelHeights || obj.toHeight == 0) ? obj.toHeight + "px" : "auto";
            }
            if (this.onComplete)
                this.onComplete();
            return;
        }

        for (i = 0; i < this.panelData.length; i++)
        {
            obj = this.panelData[i];
            var ht = this.transition(elapsedTime, obj.fromHeight, obj.distance, this.duration);
            obj.content.style.height = ((ht < 0) ? 0 : ht) + "px";
        }
	
        var self = this;
        this.timer = setTimeout(function() {
            self.stepAnimation();
        }, this.interval);
    };

})(); // EndSpryComponent




//==========================================================================================================================================================
//==========================================================================================================================================================
//==========================================================================================================================================================




(function() { // BeginSpryComponent

if (typeof Spry == "undefined") window.Spry = {}; if (!Spry.Widget) Spry.Widget = {};

Spry.Widget.TabbedPanels = function(element, opts)
{
	this.element = this.getElement(element);
	this.defaultTab = 0; // Show the first panel by default.
	this.tabSelectedClass = "TabbedPanelsTabSelected";
	this.tabHoverClass = "TabbedPanelsTabHover";
	this.tabFocusedClass = "TabbedPanelsTabFocused";
	this.panelVisibleClass = "TabbedPanelsContentVisible";
	this.focusElement = null;
	this.hasFocus = false;
	this.currentTabIndex = 0;
	this.enableKeyboardNavigation = true;
	this.nextPanelKeyCode = Spry.Widget.TabbedPanels.KEY_RIGHT;
	this.previousPanelKeyCode = Spry.Widget.TabbedPanels.KEY_LEFT;

	Spry.Widget.TabbedPanels.setOptions(this, opts);

	// If the defaultTab is expressed as a number/index, convert
	// it to an element.

	if (typeof (this.defaultTab) == "number")
	{
		if (this.defaultTab < 0)
			this.defaultTab = 0;
		else
		{
			var count = this.getTabbedPanelCount();
			if (this.defaultTab >= count)
				this.defaultTab = (count > 1) ? (count - 1) : 0;
		}

		this.defaultTab = this.getTabs()[this.defaultTab];
	}

	// The defaultTab property is supposed to be the tab element for the tab content
	// to show by default. The caller is allowed to pass in the element itself or the
	// element's id, so we need to convert the current value to an element if necessary.

	if (this.defaultTab)
		this.defaultTab = this.getElement(this.defaultTab);

	this.attachBehaviors();
};

Spry.Widget.TabbedPanels.prototype.getElement = function(ele)
{
	if (ele && typeof ele == "string")
		return document.getElementById(ele);
	return ele;
};

Spry.Widget.TabbedPanels.prototype.getElementChildren = function(element)
{
	var children = [];
	var child = element.firstChild;
	while (child)
	{
		if (child.nodeType == 1 /* Node.ELEMENT_NODE */)
			children.push(child);
		child = child.nextSibling;
	}
	return children;
};

Spry.Widget.TabbedPanels.prototype.addClassName = function(ele, className)
{
	if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) != -1))
		return;
	ele.className += (ele.className ? " " : "") + className;
};

Spry.Widget.TabbedPanels.prototype.removeClassName = function(ele, className)
{
	if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) == -1))
		return;
	ele.className = ele.className.replace(new RegExp("\\s*\\b" + className + "\\b", "g"), "");
};

Spry.Widget.TabbedPanels.setOptions = function(obj, optionsObj, ignoreUndefinedProps)
{
	if (!optionsObj)
		return;
	for (var optionName in optionsObj)
	{
		if (ignoreUndefinedProps && optionsObj[optionName] == undefined)
			continue;
		obj[optionName] = optionsObj[optionName];
	}
};

Spry.Widget.TabbedPanels.prototype.getTabGroup = function()
{
	if (this.element)
	{
		var children = this.getElementChildren(this.element);
		if (children.length)
			return children[0];
	}
	return null;
};

Spry.Widget.TabbedPanels.prototype.getTabs = function()
{
	var tabs = [];
	var tg = this.getTabGroup();
	if (tg)
		tabs = this.getElementChildren(tg);
	return tabs;
};

Spry.Widget.TabbedPanels.prototype.getContentPanelGroup = function()
{
	if (this.element)
	{
		var children = this.getElementChildren(this.element);
		if (children.length > 1)
			return children[1];
	}
	return null;
};

Spry.Widget.TabbedPanels.prototype.getContentPanels = function()
{
	var panels = [];
	var pg = this.getContentPanelGroup();
	if (pg)
		panels = this.getElementChildren(pg);
	return panels;
};

Spry.Widget.TabbedPanels.prototype.getIndex = function(ele, arr)
{
	ele = this.getElement(ele);
	if (ele && arr && arr.length)
	{
		for (var i = 0; i < arr.length; i++)
		{
			if (ele == arr[i])
				return i;
		}
	}
	return -1;
};

Spry.Widget.TabbedPanels.prototype.getTabIndex = function(ele)
{
	var i = this.getIndex(ele, this.getTabs());
	if (i < 0)
		i = this.getIndex(ele, this.getContentPanels());
	return i;
};

Spry.Widget.TabbedPanels.prototype.getCurrentTabIndex = function()
{
	return this.currentTabIndex;
};

Spry.Widget.TabbedPanels.prototype.getTabbedPanelCount = function(ele)
{
	return Math.min(this.getTabs().length, this.getContentPanels().length);
};

Spry.Widget.TabbedPanels.addEventListener = function(element, eventType, handler, capture)
{
	try
	{
		if (element.addEventListener)
			element.addEventListener(eventType, handler, capture);
		else if (element.attachEvent)
			element.attachEvent("on" + eventType, handler);
	}
	catch (e) {}
};

Spry.Widget.TabbedPanels.prototype.cancelEvent = function(e)
{
	if (e.preventDefault) e.preventDefault();
	else e.returnValue = false;
	if (e.stopPropagation) e.stopPropagation();
	else e.cancelBubble = true;

	return false;
};

Spry.Widget.TabbedPanels.prototype.onTabClick = function(e, tab)
{
	this.showPanel(tab);
	return this.cancelEvent(e);
};

Spry.Widget.TabbedPanels.prototype.onTabMouseOver = function(e, tab)
{
	this.addClassName(tab, this.tabHoverClass);
	return false;
};

Spry.Widget.TabbedPanels.prototype.onTabMouseOut = function(e, tab)
{
	this.removeClassName(tab, this.tabHoverClass);
	return false;
};

Spry.Widget.TabbedPanels.prototype.onTabFocus = function(e, tab)
{
	this.hasFocus = true;
	this.addClassName(tab, this.tabFocusedClass);
	return false;
};

Spry.Widget.TabbedPanels.prototype.onTabBlur = function(e, tab)
{
	this.hasFocus = false;
	this.removeClassName(tab, this.tabFocusedClass);
	return false;
};

Spry.Widget.TabbedPanels.KEY_UP = 38;
Spry.Widget.TabbedPanels.KEY_DOWN = 40;
Spry.Widget.TabbedPanels.KEY_LEFT = 37;
Spry.Widget.TabbedPanels.KEY_RIGHT = 39;



Spry.Widget.TabbedPanels.prototype.onTabKeyDown = function(e, tab)
{
	var key = e.keyCode;
	if (!this.hasFocus || (key != this.previousPanelKeyCode && key != this.nextPanelKeyCode))
		return true;

	var tabs = this.getTabs();
	for (var i =0; i < tabs.length; i++)
		if (tabs[i] == tab)
		{
			var el = false;
			if (key == this.previousPanelKeyCode && i > 0)
				el = tabs[i-1];
			else if (key == this.nextPanelKeyCode && i < tabs.length-1)
				el = tabs[i+1];

			if (el)
			{
				this.showPanel(el);
				el.focus();
				break;
			}
		}

	return this.cancelEvent(e);
};

Spry.Widget.TabbedPanels.prototype.preorderTraversal = function(root, func)
{
	var stopTraversal = false;
	if (root)
	{
		stopTraversal = func(root);
		if (root.hasChildNodes())
		{
			var child = root.firstChild;
			while (!stopTraversal && child)
			{
				stopTraversal = this.preorderTraversal(child, func);
				try { child = child.nextSibling; } catch (e) { child = null; }
			}
		}
	}
	return stopTraversal;
};

Spry.Widget.TabbedPanels.prototype.addPanelEventListeners = function(tab, panel)
{
	var self = this;
	Spry.Widget.TabbedPanels.addEventListener(tab, "click", function(e) { return self.onTabClick(e, tab); }, false);
	Spry.Widget.TabbedPanels.addEventListener(tab, "mouseover", function(e) { return self.onTabMouseOver(e, tab); }, false);
	Spry.Widget.TabbedPanels.addEventListener(tab, "mouseout", function(e) { return self.onTabMouseOut(e, tab); }, false);

	if (this.enableKeyboardNavigation)
	{
		// XXX: IE doesn't allow the setting of tabindex dynamically. This means we can't
		// rely on adding the tabindex attribute if it is missing to enable keyboard navigation
		// by default.

		// Find the first element within the tab container that has a tabindex or the first
		// anchor tag.
		
		var tabIndexEle = null;
		var tabAnchorEle = null;

		this.preorderTraversal(tab, function(node) {
			if (node.nodeType == 1 /* NODE.ELEMENT_NODE */)
			{
				var tabIndexAttr = tab.attributes.getNamedItem("tabindex");
				if (tabIndexAttr)
				{
					tabIndexEle = node;
					return true;
				}
				if (!tabAnchorEle && node.nodeName.toLowerCase() == "a")
					tabAnchorEle = node;
			}
			return false;
		});

		if (tabIndexEle)
			this.focusElement = tabIndexEle;
		else if (tabAnchorEle)
			this.focusElement = tabAnchorEle;

		if (this.focusElement)
		{
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "focus", function(e) { return self.onTabFocus(e, tab); }, false);
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "blur", function(e) { return self.onTabBlur(e, tab); }, false);
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "keydown", function(e) { return self.onTabKeyDown(e, tab); }, false);
		}
	}
};

Spry.Widget.TabbedPanels.prototype.showPanel = function(elementOrIndex)
{
	var tpIndex = -1;
	
	if (typeof elementOrIndex == "number")
		tpIndex = elementOrIndex;
	else // Must be the element for the tab or content panel.
		tpIndex = this.getTabIndex(elementOrIndex);
	
	if (!tpIndex < 0 || tpIndex >= this.getTabbedPanelCount())
		return;

	var tabs = this.getTabs();
	var panels = this.getContentPanels();

	var numTabbedPanels = Math.max(tabs.length, panels.length);

	for (var i = 0; i < numTabbedPanels; i++)
	{
		if (i != tpIndex)
		{
			if (tabs[i])
				this.removeClassName(tabs[i], this.tabSelectedClass);
			if (panels[i])
			{
				this.removeClassName(panels[i], this.panelVisibleClass);
				panels[i].style.display = "none";
			}
		}
	}

	this.addClassName(tabs[tpIndex], this.tabSelectedClass);
	this.addClassName(panels[tpIndex], this.panelVisibleClass);
	panels[tpIndex].style.display = "block";

	this.currentTabIndex = tpIndex;
};

Spry.Widget.TabbedPanels.prototype.attachBehaviors = function(element)
{
	var tabs = this.getTabs();
	var panels = this.getContentPanels();
	var panelCount = this.getTabbedPanelCount();

	for (var i = 0; i < panelCount; i++)
		this.addPanelEventListeners(tabs[i], panels[i]);

	this.showPanel(this.defaultTab);
};

})(); // EndSpryComponent