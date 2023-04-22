
public class test{
    public static void main(String[] args) {
        String path = "/-this-make-lo";
        path = path.replace("/-", "");
        int indexof = path.indexOf("-");
        System.out.println(path.substring(indexof+1,path.length()));
    }
}