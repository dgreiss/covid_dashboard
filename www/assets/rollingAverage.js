svg.attr("style", "")

r2d3.onRender(function (data, svg, width, height, options) {
    svg.attr("viewBox", `0 0 ${width} ${height}`)
        .attr("preserveAspectRatio", "xMinYMin meet")

    let parseTime = d3.timeParse("%Y-%m-%d");

    data.map(function (d) {
        d.reported_date = parseTime(d.reported_date),
            d.deaths = +d.mean_deaths_7
    })

    let margin = ({ top: 5, right: 10, bottom: 60, left: 40 })

    let xScale = d3.scaleBand()
        .domain(data.map(d => d.reported_date))
        .range([margin.left, width - margin.left])
        .padding(0.2);

    let yScale = d3.scaleLinear()
        .domain(d3.extent(data, d => d.deaths))
        .range([height - margin.bottom, margin.top]);

    let xAxis = d3.axisBottom()
        .tickFormat(d3.timeFormat("%Y-%m-%d"))
        .scale(xScale)
        .tickSizeOuter(0);

    let yAxis = d3.axisLeft()
        .scale(yScale)
        .tickSizeOuter(0);

    svg.selectAll('rect')
        .data(data)
        .enter().append("rect")
        .attr("width", xScale.bandwidth())
        .attr("x", d => xScale(d.reported_date))
        .attr("y", d => yScale(d.deaths))
        .attr("height", d => height - margin.bottom - yScale(d.deaths))

    svg.append("g")
        .attr("transform", `translate(0, ${height - margin.bottom})`)
        .call(xAxis)
        .selectAll("text")
        .style("text-anchor", "end")
        .attr("dx", "-.8em")
        .attr("dy", ".15em")
        .attr("transform", "rotate(-65)")

    svg.append("g")
        .attr("class", "axis")
        .attr("transform", `translate(${margin.left}, 0)`)
        .call(yAxis)
});

r2d3.onResize(function (width, height) {

}); 