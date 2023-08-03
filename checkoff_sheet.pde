String[] tasks;
int rows=25, cols=7;
int taskCellSize=3;
//boolean[][] grid=new boolean[rows][cols];
int gridx, gridy;
checkCell[][] grid;
String saveLocation = System.getProperty("user.home")+"/library/Application Support/point system/";
String[] weekdays={"sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"};
textCell[] days;
textCell[] taskCells;
int totalDone=0, totalUndone;
textCell done;
int numberTasksCount=1;
numberCell[][] numberTasks;
//char[] cellType=new char[0];
void setup() {
  tasks=loadStrings(saveLocation+"tasks.txt");
  fullScreen();
  background(0);
  //for (int i=0; i<tasks.length; i++) {
  //  cellType=append(cellType, tasks[i].charAt(0));
  //  tasks[i]=tasks[i].substring(1);
  //}
  rows=tasks.length;
  gridx=width/(cols+taskCellSize)*cols;
  gridy=height/(rows+1)*rows;
  grid=new checkCell[rows-numberTasksCount][cols];
  for (int i=0; i<rows-numberTasksCount; i++) {
    for (int j=0; j<cols; j++) {
      grid[i][j]=new checkCell(width/(cols+taskCellSize)*(j+taskCellSize), height/(rows+1)*(i+1), width/(cols+taskCellSize), height/(rows+1));
    }
  }
  days=new textCell[weekdays.length];
  for (int i=0; i<days.length; i++) {
    days[i]=new textCell(width/(cols+taskCellSize)*(i+taskCellSize), 0, width/(cols+taskCellSize), height/(rows+1), weekdays[i]);
  }
  taskCells=new textCell[tasks.length];
  for (int i=0; i<taskCells.length; i++) {
    taskCells[i]=new textCell(0, height/(rows+1)*(i+1), width/(cols+taskCellSize)*taskCellSize, height/(rows+1), tasks[i]);
  }
  totalUndone=days.length*tasks.length;
  done=new textCell(0, 0, width/(cols+taskCellSize)*taskCellSize, height/(rows+1), "Green: "+totalDone+"   Red: "+totalUndone);
  numberTasks=new numberCell[numberTasksCount][weekdays.length];
  for (int i=0; i<numberTasksCount; i++) {
    for (int j=0; j<weekdays.length; j++) {
      numberTasks[i][j]=new numberCell(width/(cols+taskCellSize)*(j+taskCellSize), height/(rows+1)*(i+1+rows-numberTasksCount), width/(cols+taskCellSize), height/(rows+1));
    }
  }
  load();
}
void draw() {
  background(0);
  for (checkCell[] cellarr : grid)for (checkCell cell : cellarr)cell.draw();
  for (numberCell[] cellarr : numberTasks)for (numberCell cell : cellarr)cell.draw();
  for (textCell cell : days)cell.draw();
  for (textCell cell : taskCells)cell.draw();
  done.draw();
}
void keyPressed() {
  if (key=='c') {
    for (int i=0; i<rows-numberTasksCount; i++) {
      for (int j=0; j<cols; j++) {
        grid[i][j]=new checkCell(width/(cols+taskCellSize)*(j+taskCellSize), height/(rows+1)*(i+1), width/(cols+taskCellSize), height/(rows+1));
      }
    }
    for (int i=0; i<numberTasksCount; i++) {
      for (int j=0; j<weekdays.length; j++) {
        numberTasks[i][j]=new numberCell(width/(cols+taskCellSize)*(j+taskCellSize), height/(rows+1)*(i+1+rows-numberTasksCount), width/(cols+taskCellSize), height/(rows+1));
      }
    }
  }
  save();
}
void mousePressed() {
  for (checkCell[] cellarr : grid)for (checkCell cell : cellarr)cell.mousePressed();
  for (numberCell[] cellarr : numberTasks)for (numberCell cell : cellarr)cell.mousePressed();
  done.text="Green: "+totalDone+"   Red: "+totalUndone;
  save();
}
void save() {
  byte[] save=new byte[0];
  for (checkCell[] cellarr : grid)for (checkCell cell : cellarr)save=append(save, byte(cell.value));
  saveBytes(saveLocation+"grid.bin", save);
  byte[] numberSave=new byte[0];
  for (numberCell[] cellarr : numberTasks)for (numberCell cell : cellarr)numberSave=append(numberSave, byte(cell.value));
  saveBytes(saveLocation+"numberTasks.bin", numberSave);
}
void load() {
  File gridsave=new File(saveLocation+"grid.bin");
  boolean[][] gridload=new boolean[rows-numberTasksCount][cols];
  if (gridsave.exists()) {
    if (gridsave.length()<=(tasks.length-numberTasksCount)*days.length) {
      byte[] load=loadBytes(gridsave);
      for (int i=0; i<load.length; i++) {
        gridload[floor(i/cols)][i%cols]=boolean(load[i]);
      }
      for (int i=0; i<rows-numberTasksCount; i++) {
        for (int j=0; j<cols; j++) {
          grid[i][j].value=gridload[i][j];
          totalUndone-=int(gridload[i][j]);
          totalDone+=int(gridload[i][j]);
        }
      }
    }
  }
  File numberSave=new File(saveLocation+"numberTasks.bin");
  int[][] numberLoad=new int[numberTasksCount][cols];
  if (numberSave.exists()) {
    if (numberSave.length()<=(numberTasksCount)*days.length) {
      byte[] load=loadBytes(numberSave);
      for (int i=0; i<load.length; i++) {
        numberLoad[floor(i/cols)][i%cols]=int(load[i]);
      }
      for (int i=0; i<numberTasksCount; i++) {
        for (int j=0; j<cols; j++) {
          numberTasks[i][j].value=numberLoad[i][j];
          totalDone+=numberLoad[i][j];
          if (numberLoad[i][j]>0)totalUndone--;
        }
      }
    }
  }
  done.text="Green: "+totalDone+"   Red: "+totalUndone;
}
