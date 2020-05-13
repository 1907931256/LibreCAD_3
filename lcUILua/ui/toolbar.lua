toolbars = {}

--[[--Create a new action in given menu with name and icon
function create_action(menu, name, icon)
    local action = menu:addActionStr(qt.QString(name))

    if(icon ~= nil) then
        action:setIcon(qt.QIcon(qt.QString(icon)))
    end

    return action
end]]--

--Add toolbar to main window
function add_toolbar(id)
    local toolbar = mainWindow:getToolbar()
    toolbars[id] = {
        widget = toolbar,
        tabs = {}
    }

    local quickAccessTab = toolbar:tabByName("Quick Access")

    local creationGroup = quickAccessTab:addGroup("Creation")
    toolbar:addButton("", ":/icons/linesnormal.png", creationGroup, 0, 0, function() run_basic_operation(id, LineOperations) end, "Line")
    toolbar:addButton("", ":/icons/circle.svg", creationGroup, 1, 0, function() run_basic_operation(id, CircleOperations) end, "Circle")
    toolbar:addButton("", ":/icons/arc.svg", creationGroup, 0, 1, function() run_basic_operation(id, ArcOperations) end, "Arc")
    toolbar:addButton("", ":/icons/spline.svg", creationGroup, 2, 0, function() run_basic_operation(id, SplineOperations) end, "Spline")
    toolbar:addButton("", ":/icons/polylines.svg", creationGroup, 2, 1, function() create_lw_polyline(id) end, "Polyline")

    --
    -- Ellipses
    --
    toolbar:addButton("", ":/icons/ellipse.svg", creationGroup, 1, 1, function() run_basic_operation(id, EllipseOperations) end, "Ellipse")
    --local ellipseButton = create_button("", ":/icons/ellipse.svg", "Ellipse")
    --[[local ellipseMenu = qt.QMenu()

    local ellipseAction = create_action(ellipseMenu, "Ellipse", ":/icons/ellipse_axis.svg")
    luaInterface:luaConnect(ellipseAction, "triggered(bool)", function() run_basic_operation(id, EllipseOperations) end)

    local arcEllipseAction = create_action(ellipseMenu, "Arc Ellipse", ":/icons/ellipse_arc_axis.svg")
    luaInterface:luaConnect(arcEllipseAction, "triggered(bool)", function() run_basic_operation(id, EllipseOperations, "_init_arc") end)

    ellipseButton:setMenu(ellipseMenu)
    quickAccessTab:addWidget(creationGroup, ellipseButton, 1, 1, 1, 1)]]--
    --
    -- Dimensions
    --
    local dimGroup = quickAccessTab:addGroup("Dimensions")
    toolbar:addButton("", ":/icons/dim_aligned.svg", dimGroup, 0, 0, function() run_basic_operation(id, DimAlignedOperations) end, "Aligned Dimension")
    toolbar:addButton("", ":/icons/dim_angular.svg", dimGroup, 1, 0, function() run_basic_operation(id, DimAngularOperations) end, "Angular Dimension")
    toolbar:addButton("", ":/icons/dim_diametric.svg", dimGroup, 0, 1, function() run_basic_operation(id, DimDiametricOperations) end, "Diametric Dimension")
    toolbar:addButton("", ":/icons/dim_linear.svg", dimGroup, 1, 1, function() run_basic_operation(id, DimLinearOperations) end, "Linear Dimension")
    toolbar:addButton("", ":/icons/dim_radial.svg", dimGroup, 2, 0, function() run_basic_operation(id, DimRadialOperations) end, "Radial Dimension")

    --
    -- Modify
    --
    local modifyGroup = quickAccessTab:addGroup("Modify")
    toolbar:addButton("", ":/icons/modifymove.png", modifyGroup, 0, 0, function() run_basic_operation(id, MoveOperation) end, "Move")
    toolbar:addButton("", ":/icons/modifyrotate.png", modifyGroup, 1, 0, function() run_basic_operation(id, RotateOperation) end, "Rotate")
    toolbar:addButton("", ":/icons/move_copy.svg", modifyGroup, 0, 1, function() run_basic_operation(id, CopyOperation) end, "Copy")
    toolbar:addButton("", ":/icons/scale.png", modifyGroup, 1, 1, function() run_basic_operation(id, ScaleOperation) end, "Scale")
    toolbar:addButton("", ":/icons/delete.svg", modifyGroup, 2, 0, function() run_basic_operation(id, RemoveOperation) end, "Delete")
    toolbar:addButton("", ":/icons/modifytrim.png", modifyGroup, 2, 1, function() run_basic_operation(id, TrimOperation) end, "Trim")

    --
    -- Snap options
    --
    local snapOptionGroup = quickAccessTab:addGroup("Snap options")
    toolbar:addCheckableButton("", ":/icons/snap_grid.svg", snapOptionGroup, 0, 0, function(enabled)
        getWindow(id):getSnapManager():setGridSnappable(enabled)
    end, "Move")
    toolbar:addCheckableButton("", ":/icons/snap_intersection.svg", snapOptionGroup, 0, 1, function(enabled)
        getWindow(id):getSnapManager():setIntersectionSnappable(enabled)
    end, "Snap Intersection")
    toolbar:addCheckableButton("", ":/icons/snap_middle.svg", snapOptionGroup, 1, 0, function(enabled)
        getWindow(id):getSnapManager():setMiddleSnappable(enabled)
    end, "Snap Middle")
    toolbar:addCheckableButton("", ":/icons/snap_entity.svg", snapOptionGroup, 1, 1, function(enabled)
        getWindow(id):getSnapManager():setEntitySnappable(enabled)
    end, "Snap Entity")
end
