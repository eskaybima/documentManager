package com.fasyl.vo;

public class MultiSearcherVo {

    public boolean next;
    public boolean previous;
    public int fetchSize = 3;
    public int nextStart;
    public int nextStop;
    public int currentStart;
    public int currentStop;
    public int previousStart;
    public int previousStop;
    public String query;
    public String queryRange;
    public int totalCount;

    public MultiSearcherVo() {
        next = false;
        previous = false;
        nextStart = 101;
        nextStop = 200;
        currentStart = 1;
        currentStop = 100;
        previousStart = currentStart;
        previousStop = currentStop;
        query = null;
        queryRange = " RowNum between " + currentStart + " and " + currentStop;
        totalCount = 0;
    }

    public void setTotalCount(int total) {
        if (total > fetchSize) {
            next = true;
        } else {
            next = false;
        }
        totalCount = total;
    }

    public void setNextRange() {
        previous = true;
        previousStart = currentStart;
        previousStop = currentStop;
        currentStart = nextStart;
        currentStop = nextStop;
        if (totalCount > nextStop) /*  38:    */ {
            next = true;
            nextStart = fetchSize + nextStart;
            nextStop = fetchSize + nextStop;
            if (nextStop > totalCount) {
                nextStop = totalCount;
            }
        } else {
            next = false;
        }
    }

    public void setPreviousRange() {
        next = true;
        int nexst = nextStop;
        nextStart = currentStart;
        nextStop = currentStop;
        currentStart = previousStart;
        currentStop = previousStop;
        if (previousStart > fetchSize) {
            previous = true;
            if (nexst == totalCount) {
                previousStop = previousStart - 1;
            } else {
                previousStop -= fetchSize;
            }
            previousStart -= fetchSize;
        } else {
            previous = false;
        }
    }

    public String getRange() {
        return " RowNum between " + currentStart + " and " + currentStop;
    }

    public String getNextRange() {
        return " RowNum between " + nextStart + " and " + nextStop;
    }

    public String getPreviousRange() {
        return " RowNum between " + previousStart + " and " + previousStop;
    }  
}
